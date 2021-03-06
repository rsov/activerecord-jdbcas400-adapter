require 'test_helper'

class TestAdapter < Test::Unit::TestCase

  def test_schema
    assert_equal(config[:schema], connection.schema)
    assert_equal(nil, system_connection.schema)
  end

  def test_system_naming?
    assert_false(connection.instance_eval {system_naming?})
    assert_true(system_connection.instance_eval {system_naming?})
  end

  def test_prefetch_primary_key?
    begin
      connection.execute('CREATE TABLE test_table (test_column INTEGER)')
      assert_true(connection.prefetch_primary_key?('test_table'))
    ensure
      connection.execute('DROP TABLE test_table')
    end

    begin
      connection.execute('CREATE TABLE test_table (test_column INTEGER, PRIMARY KEY(test_column))')
      assert_false(connection.prefetch_primary_key?('test_table'))
    ensure
      connection.execute('DROP TABLE test_table')
    end
  end

  def test_truncate
    begin
      connection.execute('CREATE TABLE test_table (test_column INTEGER)')
    ensure
      if connection.os400_version[:major] < 7 || (connection.os400_version[:major] == 7 && connection.os400_version[:minor] < 2)
        assert_raise NotImplementedError do
          connection.truncate 'test_table'
        end
      else
        assert_nothing_raised do
          connection.truncate 'test_table'
        end
      end
      connection.execute('DROP TABLE test_table')
    end
  end

  def test_rename_column
    begin
      connection.execute('CREATE TABLE test_table (test_column INTEGER)')
      connection.execute('INSERT INTO test_table(test_column) VALUES(1)')

      assert_raise do
        connection.rename_column('test_table', 'no_column', '')
      end

      connection.rename_column('test_table', 'test_column', 'new_test_column')
      assert_not_nil(connection.columns('test_table').find { |column| column.name == 'new_test_column' })
      assert_equal(1, connection.select_one('SELECT new_test_column FROM test_table')['new_test_column'])
    ensure
      connection.execute('DROP TABLE test_table')
    end
  end

  def test_transaction_isolation_levels
    assert_equal('NO COMMIT', connection.transaction_isolation_levels.fetch(:no_commit))
  end

  def test_table_exists
    begin
      connection.execute('CREATE TABLE test_table (test_column INTEGER)')
      assert_true(system_connection.table_exists?('test_table'))
    ensure
      connection.execute('DROP TABLE test_table')
    end
  end

end
