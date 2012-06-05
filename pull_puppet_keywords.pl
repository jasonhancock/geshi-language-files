#!/usr/bin/perl

# Copyright (c) 2012 Jason Hancock <jsnbyh@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is furnished
# to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# This file is part of the nagios-cpu bundle that can be found
# at https://github.com/jasonhancock/geshi-language-files 

use strict;
use warnings;

my %types;
my %attributes;

# Manually add the firewall type and all attributes from the 
# puppetlabs-firewall module
$types{'firewall'} = 1;
$attributes{'name'} = 1;
$attributes{'action'} = 1;
$attributes{'source'} = 1;
$attributes{'destination'} = 1;
$attributes{'sport'} = 1;
$attributes{'dport'} = 1;
$attributes{'proto'} = 1;
$attributes{'chain'} = 1;
$attributes{'table'} = 1;
$attributes{'jump'} = 1;
$attributes{'iniface'} = 1;
$attributes{'outiface'} = 1;
$attributes{'tosource'} = 1;
$attributes{'todest'} = 1;
$attributes{'toports'} = 1;
$attributes{'reject'} = 1;
$attributes{'log_level'} = 1;
$attributes{'log_prefix'} = 1;
$attributes{'icmp'} = 1;
$attributes{'state'} = 1;
$attributes{'limit'} = 1;
$attributes{'burst'} = 1;

# Puppet Type Reference
my @lines = `wget -q -O - http://docs.puppetlabs.com/references/stable/type.html`;

parseLines(@lines);

# The meta parameters:
@lines = `wget -q -O - http://docs.puppetlabs.com/references/stable/metaparameter.html`;

parseLines(@lines);

print "TYPES:\n";
foreach my $key(sort keys %types) {
    print "            '$key',\n";
}

print "\n\n\n";
print "ATTRIBUTES\n";

foreach my $key(sort keys %attributes) {
    print "            '$key',\n";
}

sub parseLines {
    my (@lines) = @_;

    foreach my $line(@lines) {
        chomp($line);

        if($line=~m/^  <dt>(.+)<\/dt>/) {
            $attributes{$1} = 1;
        } elsif($line=~m/<h3 id="(.+?)">/) {
            $types{$1} = 1;
        }
    }
}
