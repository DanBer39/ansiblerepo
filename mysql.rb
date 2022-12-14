class { 'mysql::server':
  root_password           => 'strongpassword',
  remove_default_accounts => true,
  restart                 => true,
  override_options        => $override_options,
}

$override_options = {
  'mysqld' => {
    'replicate-do-db' => ['base1', 'base2'],
  },
}


mysql::db { 'mydb':
  user     => 'myuser',
  password => 'mypass',
  host     => 'localhost',
  grant    => ['SELECT', 'UPDATE'],
}

@@mysql::db { "mydb_${fqdn}":
  user     => 'myuser',
  password => 'mypass',
  dbname   => 'mydb',
  host     => ${fqdn},
  grant    => ['SELECT', 'UPDATE'],
  tag      => $domain,
}