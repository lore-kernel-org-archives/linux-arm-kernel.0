From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Sep 2016 23:13:25 +0200
Subject: [GIT PULL] Allwinner core changes for 4.9
Message-ID: <20160911211325.GA18519@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-core-for-4.9

for you to fetch changes up to c1efda1238be1efa8612e26ee98795298ffd6f95:

  ARM: sunxi: Support the Nextthing GR8 (2016-09-08 14:32:23 +0200)

----------------------------------------------------------------
Allwinner core changes for 4.9

Add support for big endian on the Allwinner A20, and the Nextthing GR8 SoC

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: sunxi: Support the Nextthing GR8

Michael Weiser (1):
      ARM: sunxi: enable big-endian

 Documentation/arm/sunxi/README                  | 2 ++
 Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
 MAINTAINERS                                     | 1 +
 arch/arm/mach-sunxi/Kconfig                     | 1 +
 arch/arm/mach-sunxi/sunxi.c                     | 1 +
 5 files changed, 6 insertions(+)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160911/ed8910f1/attachment.sig>
