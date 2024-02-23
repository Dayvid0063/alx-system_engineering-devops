# Using Puppet, install flask

package {'flask':
  ensure   => '2.',
  provider => 'pip3'
}
