From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 22 Dec 2009 00:21:12 +0100
Subject: [PATCH 0/10] ARM-PNX4008-clocking update patches (repost)
Message-ID: <083DF309106F364B939360100EC290F804F592E900@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


These patches were originally submitted by Russell King to
update the PNX4008 platform clock functions. These add
better support for CLKDEV and I2C and WDT clocking updates
needed for other platforms with this same IP.

These changes have been tested on the LPC32xx platform
which uses the same I2C and WDT peripherals as the
PNX4008 platform.

Kevin
