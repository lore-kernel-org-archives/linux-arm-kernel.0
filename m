From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Aug 2017 11:22:46 +0200
Subject: [GIT PULL] Allwinner DT changes for 4.14, take 3
Message-ID: <20170828092246.h66hjoqmv3r3kpes@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is a late pull request for the 4.14 merge window.

Along with the fixes pull request I'm about to change, this should be
our last pull request for the next release.

Thanks!
Maxime

The following changes since commit 75ce73fdadf6944d6948f45b34cbfd7aa01190cc:

  ARM: sun8i: a83t: h8homlet-v2: Enable USB ports (2017-08-19 00:25:25 +0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-4.14-3

for you to fetch changes up to 6b0e06df5cadba8471524266cc472dbbda55146b:

  Revert "ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Beelink X2" (2017-08-28 10:56:32 +0200)

----------------------------------------------------------------
Allwinner DT changes for 4.14, take 3

One new board, and a revert of a patch relying on a binding not stable
enough so that we can commit to it.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: sun8i: a83t: Add device tree for Sinovoip Bananapi BPI-M3

Maxime Ripard (1):
      Revert "ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Beelink X2"

 arch/arm/boot/dts/Makefile                   |   1 +
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 148 +++++++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts    |   9 +-
 3 files changed, 150 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170828/18b51e7e/attachment.sig>
