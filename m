From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Nov 2017 10:29:58 +0100
Subject: [GIT PULL] Allwinner arm64 DT changes for 4.15, step 2
Message-ID: <20171106092958.viqi2q3vscrhekwk@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is our final pull request for 4.15, with the reintroduction of
the EMAC bindings that were reverted at the last minute during the
4.13 development cycle.

They've been in linux-next since last wednesday, so they should have
had a decent amount of CI already.

Thanks!
Maxime

The following changes since commit d25d41827fee2b489518eee99ef156b005c0c01e:

  arm: allwinner: Correct unit name in devicetree binding example (2017-09-28 18:23:50 +0200)

are available in the Git repository at:

  ssh://git at gitolite.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt64-for-4.15-2

for you to fetch changes up to 16416084e06e1ebff51a9e7721a8cc4ccc186f28:

  arm64: dts: allwinner: add snps,dwmac-mdio compatible to emac/mdio (2017-10-31 14:32:08 +0100)

----------------------------------------------------------------
Allwinner arm64 changes, take 2

Reintroduction of the EMAC bindings that were reverted in 4.13.

----------------------------------------------------------------
Corentin Labbe (2):
      arm64: dts: allwinner: A64: Restore EMAC changes
      arm64: dts: allwinner: add snps,dwmac-mdio compatible to emac/mdio

 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts  | 16 ++++++++++++++++
 .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts   | 15 +++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 17 +++++++++++++++++
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts   | 16 ++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi       | 21 +++++++++++++++++++++
 5 files changed, 85 insertions(+)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171106/a3c60ca3/attachment.sig>
