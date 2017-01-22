From: mzoran@crowfest.net (Michael Zoran)
Date: Sun, 22 Jan 2017 00:07:04 -0800
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
Message-ID: <1485072424.14066.2.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm not sure if this if the correct place to be asking this.   The RPI
3 running ARM64 is slowly reaching the point of being about to
seriously run a 32 bit vender OS like Raspbian.  When running Raspbian,
I'm seeing a very large number(thousands) of kernel log messages about
deprecated instructions especially setend and barrier instuctions. 
This can be very annoying and is completely filling the kernel log.

I'm considering submitting a patch to add a Kconfig option to disable
these warnings with the default being to keep the warnings enabled.  I
was wondering if such a patch could be seriously considered.

I completely understand thee need for these warnings and the need to
encourage people to update software, but at the same time some software
like Raspbian needs to run on a large number of processors with a
simple install so updating isn't always realistic.  

Running a 64 bit kernel with a 32 bit userland is better from a upgrade
point of view then always running 32 just because they want to not have
the machine slowed by excessive logging.

Thanks.
