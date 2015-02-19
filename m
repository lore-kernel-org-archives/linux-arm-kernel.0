From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Feb 2015 17:12:20 +0000
Subject: Announce: rmk's nightly builder gets ARM64 support
Message-ID: <20150219171220.GA8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Today, I have added ARM64 support to my automated nightly kernel builder.
Initially, this will result in ARM64 builds being tested with allnoconfig
and defconfig, and I shall add allmodconfig and allyesconfig to this in
the coming days.

Once that is done and stable, I will investigate adding an ARM Juno
platform to my boot farm so we can run the results of the builder.

Other recent changes have been a disk upgrade, so the builder now has
plenty of disk space to run the allmodconfig and allyesconfig, which
used to fail (or be skipped) when the disk space was low.

I've also added a new ARM target for building the defconfig without a
seed.

As ever, all results are in the usual place, at:

http://www.arm.linux.org.uk/developer/build/

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
