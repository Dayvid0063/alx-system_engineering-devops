# Using Puppet, install flask

package {'flask':
  ensure   => '2.1',
  provider => 'pip3'
}
