From: dinguyen@altera.com (dinguyen at altera.com)
Date: Sun, 18 May 2014 22:47:21 -0500
Subject: [GIT PULL] SOCFPGA DTS updates for 3.16, take 2
Message-ID: <1400471241-21456-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling in this patch for 3.16. This patch adds the DTS
entries for the GPIOs on the SOCFPGA platform.

Olof had a question regarding how the GPIO node needed 2-layer approach.

http://thread.gmane.org/gmane.linux.kernel/1671569/focus=1702208

I hope that Alan Tull was able to answer Olof's question.

Thanks,

The following changes since commit 2bfac3a551978c4953f659e1bd18d58c3c249f64:

  Merge tag 'socfpga-dt-updates-for-3.16_v3' of git://git.rocketboards.org/linux-socfpga-next into next/dt (2014-05-16 16:07:37 -0700)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_dt_updates-for-3.16_take_2

for you to fetch changes up to 45e3e6316ba45980c756189fdcd79f11e5984501:

  ARM: dts: socfpga: add gpio pieces (2014-05-18 21:39:59 -0500)

----------------------------------------------------------------
Add the gpio dts entry for the SOCFPGA platform.

----------------------------------------------------------------
Sebastian Andrzej Siewior (1):
      ARM: dts: socfpga: add gpio pieces

 arch/arm/boot/dts/socfpga.dtsi |   60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
