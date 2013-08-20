From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Aug 2013 09:59:29 +0200
Subject: [GIT PULL] Allwinner sunXi core additions for 3.12, take 2
Message-ID: <20130820075929.GA11906@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29d3d373e2a780b6e818f296ece6cc29742bc11f:

  ARM: sunxi: Remove Makefile.boot file (2013-07-29 13:55:41 +0200)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-core-for-3.12-2

for you to fetch changes up to d18fd9445b18c4adf56cfc58c378c702c8edd0da:

  ARM: sunxi: Introduce Allwinner A20 support (2013-08-16 23:23:41 +0200)

----------------------------------------------------------------
Allwinner sunXi core additions for 3.12, take 2

These patches add machine support for the Allwinner A20 and A31 SoCs

----------------------------------------------------------------
Maxime Ripard (3):
      ARM: sunxi: Add the Allwinner A31 compatible to the machine definition
      ARM: sun6i: Add restart code for the A31
      ARM: sunxi: Introduce Allwinner A20 support

 .../watchdog/{sun4i-wdt.txt => sunxi-wdt.txt}      |  5 ++-
 arch/arm/mach-sunxi/Kconfig                        |  2 +
 arch/arm/mach-sunxi/sunxi.c                        | 45 ++++++++++++++++++++--
 3 files changed, 47 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/watchdog/{sun4i-wdt.txt => sunxi-wdt.txt} (56%)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130820/3cd5836e/attachment.sig>
