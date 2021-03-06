include wait_for

################################################################################
# All examples are commented out by default.
# Remove the hashes to give them a try.
################################################################################


# Example for Linux: This waits until the sshd service has started.
#
# Remark: You do not need to do this if you use a proper service resource
# to start the service. After all, this is just an example.
# wait_for { 'service sshd status':
#   regex   => '.*is running.*',
# }

# Example for Windows: This waits until the MySQL5 service has started.
#
# Remark: You do not need to do this if you use a proper service resource
# to start the service. After all, this is just an example.
# wait_for { 'sc query MySQL5':
#   regex   => '.*STATE\s*:\s*4\s*RUNNING.*',
# }

# This will wait until the command returns with exit code 42. Of course,
# this will never happen for the echo command, so this example will always
# fail. If you replace 42 with 0, it will succeed immediately, without
# waiting.
# wait_for { 'echo foobar':
#   exit_code         => 42,
#   polling_frequency => 0.3,
#   max_retries       => 5,
# }

# This will simply wait for one minute
# wait_for { 'a_minute':
#   seconds => 60,
# }

# This is actually illegal because one of regex or exit_code has to be specified.
# wait_for { 'echo abc':
# }

# This is also illegal because only one of regex or exit_code can be specified.
# wait_for { 'echo xyz':
#   regex     => 'whatever',
#   exit_code => 0,
# }

# The name of the namevar (which is the command to query the current state) is query, by the way.
# wait_for { 'without implicit namevar':
#   query   => 'echo foobar',
#   regex   => 'foobar',
# }

# Tests added for the refreshonly feature.

# file { '/tmp/exit_code.sh':
#   ensure  => file,
#   mode    => '0755',
#   content => "#!/bin/bash
# sleep 5
# exit 42
# ",
# }

# file { '/tmp/gen_log.sh':
#   ensure => file,
#   mode   => '0755',
#   content => "#!/bin/bash
# sleep 20
# echo bar >> /tmp/logfile
# ",
# }

# notify { 'expecting to see Wait_for A, C and E': }

# notify { 'A': }
# ~>
# wait_for { 'A':
#   seconds     => 1,
#   refreshonly => true,
# }

# wait_for { 'B_should_not_run':
#   seconds     => 5,
#   refreshonly => true,
# }

# notify { 'C': }
# ~>
# wait_for { 'C':
#   query       => '/tmp/exit_code.sh',
#   exit_code   => 42,
#   refreshonly => true,
# }

# wait_for { 'D_should_not_run':
#   query       => 'echo hello',
#   regex       => 'world',
#   refreshonly => true,
# }

# exec { '/tmp/gen_log.sh': }
# ~>
# wait_for { 'E':
#   query       => 'cat /tmp/logfile',
#   regex       => 'bar',
#   refreshonly => true,
# }
