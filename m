From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 27 Jul 2017 22:54:53 +0800
Subject: [GIT PULL] Allwinner fixes for 4.13
Message-ID: <20170727145453.il2nepmrrr355fgp@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

I will be handling some of the pull requests this cycle.
Here are some fixes we would like merged for 4.13.

Thanks!
ChenYu


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-fixes-for-4.13

for you to fetch changes up to c50f9fb6c535edf4731eecb53d91ebc297e82e5b:

  ARM: dts: sun8i: a83t: Switch to CCU device tree binding macros (2017-07-27 21:18:48 +0800)

----------------------------------------------------------------
Allwinner fixes for 4.13

Two fixes to correct the EMAC blocks memory region size to match the
datasheet. One that converts raw A83T clock indices to macros from the
clk dt-binding header, completing the A83T sunxi-ng clk driver.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: dts: sun8i: a83t: Switch to CCU device tree binding macros

Corentin Labbe (2):
      ARM: dts: sunxi: h3/h5: Correct emac register size
      arm64: allwinner: sun50i-a64: Correct emac register size

 arch/arm/boot/dts/sun8i-a83t.dtsi             | 16 +++++++++-------
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170727/a32e23c9/attachment.sig>
