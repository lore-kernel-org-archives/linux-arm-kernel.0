From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 17 Oct 2015 19:05:41 +0200
Subject: [GIT PULL] Allwinner defconfig changes for 4.4
Message-ID: <20151017170541.GA17582@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following tag for the next merge window.

Thanks!
Maxime

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-defconfig-for-4.4

for you to fetch changes up to 21e29d9afd1024b63a311172bf57c41223665299:

  ARM: sunxi_defconfig: enable MODULE_UNLOAD (2015-09-21 09:05:13 +0200)

----------------------------------------------------------------
Allwinner defconfig changes for 4.4

A bunch of defconfig changes to enable support for new drivers.

----------------------------------------------------------------
Gerhard Bertelsmann (2):
      can: Allwinner A10/A20 CAN Controller support - Defconfig
      can: Allwinner A10/A20 CAN Controller support - Defconfig

Jonathan Liu (1):
      ARM: sunxi_defconfig: enable MODULE_UNLOAD

Priit Laes (1):
      ARM: sunxi_defconfig: Enable LRADC keys (KEYBOARD_SUN4I_LRADC)

 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/sunxi_defconfig    | 4 ++++
 2 files changed, 5 insertions(+)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151017/2c565730/attachment.sig>
