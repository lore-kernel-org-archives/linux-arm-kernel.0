From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Jun 2017 22:15:49 +0200
Subject: [GIT PULL] Allwinner fixes for 4.12
Message-ID: <20170614201549.psaamipvsvy5swbt@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is a few fixes we should merge for 4.12

Thanks!
Maxime

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-fixes-for-4.12

for you to fetch changes up to f74994a94063bc85ac1d6ad677ed06b5279c101f:

  arm64: allwinner: a64: Add PLL_PERIPH0 clock to the R_CCU (2017-06-03 10:04:49 +0800)

----------------------------------------------------------------
Allwinner fixes for 4.12

A few fixes around the PRCM support that got in 4.12 with a wrong
compatible, and a missing clock in the binding.

----------------------------------------------------------------
Chen-Yu Tsai (2):
      ARM: sunxi: h3-h5: Add PLL_PERIPH0 clock to the R_CCU
      arm64: allwinner: a64: Add PLL_PERIPH0 clock to the R_CCU

Icenowy Zheng (1):
      ARM: sunxi: h3/h5: fix the compatible of R_CCU

Maxime Ripard (1):
      arm64: allwinner: h5: Remove syslink to shared DTSI

 arch/arm/boot/dts/sunxi-h3-h5.dtsi             | 7 ++++---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi  | 5 +++--
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi   | 2 +-
 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi | 1 -
 4 files changed, 8 insertions(+), 7 deletions(-)
 delete mode 120000 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170614/668b24d5/attachment.sig>
