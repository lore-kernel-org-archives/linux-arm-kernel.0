From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 20 Dec 2017 11:16:14 +0100
Subject: [GIT PULL] ARM: at91: Fixes for 4.15
Message-ID: <20171220101614.GA844@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

A single fix for 4.15. The driver part of it will land in 4.15 through
the hwmon tree.

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.15-dt-fixes

for you to fetch changes up to bc53e3aa88e8240823c1c440e6bab3c3a5ba5f59:

  ARM: dts: at91: disable the nxp,se97b SMBUS timeout on the TSE-850 (2017-12-04 20:30:38 +0100)

----------------------------------------------------------------
Fixes for 4.15:

 - tse850-3: fix an i2c timeout issue

----------------------------------------------------------------
Peter Rosin (1):
      ARM: dts: at91: disable the nxp,se97b SMBUS timeout on the TSE-850

 arch/arm/boot/dts/at91-tse850-3.dts | 1 +
 1 file changed, 1 insertion(+)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
