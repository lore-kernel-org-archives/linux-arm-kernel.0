From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 24 Feb 2012 23:08:32 +0100
Subject: [GIT PULL] ARM: OMAP: DTS updates
Message-ID: <4F480A60.6070208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Here are a couple of DTS files updates for 3.4.

Vaibhav sent a couple more DTS but they are still pending Grant's Acked-by.

Thanks,
Benoit


The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:
  Linus Torvalds (1):
        Linux 3.3-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dts_updates

Benoit Cousson (3):
      arm/dts: OMAP4: Add i2c controller nodes
      arm/dts: OMAP3: Add i2c controller nodes
      arm/dts: OMAP4: Update DTS file with new GIC bindings

Vaibhav Hiremath (1):
      arm/dts: Add support for TI OMAP3 EVM board

 arch/arm/boot/dts/omap3-evm.dts |   20 ++++++++++++++++++++
 arch/arm/boot/dts/omap3.dtsi    |   21 +++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi    |   30 +++++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-evm.dts
