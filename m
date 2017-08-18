From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 18 Aug 2017 12:04:47 +0800
Subject: [GIT PULL] Allwinner fixes for 4.13 round 2
Message-ID: <20170818040447.ddz27hm3c2eashjr@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is the second batch of fixes for 4.13. This is based on the first
batch of fixes that was already merged.

We still have some device tree binding changes for the H3 EMAC and
integrated Ethernet PHY we need to sort out for 4.13. If it is not
done by next week, I will send out revert patches for the driver,
device tree binding, and device tree changes. Or is this cutting
it too close and we should just revert them now?


Thanks
ChenYu

The following changes since commit c50f9fb6c535edf4731eecb53d91ebc297e82e5b:

  ARM: dts: sun8i: a83t: Switch to CCU device tree binding macros (2017-07-27 21:18:48 +0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi-fixes-for-4.13-2

for you to fetch changes up to d86e63e1f0b7868c55c8d4a54854b85e2bac690b:

  arm64: allwinner: h5: fix pinctrl IRQs (2017-08-14 14:18:21 +0800)

----------------------------------------------------------------
Allwinner fixes for 4.13, round 2

Three fixes adding a missing alias for the Ethernet controller on A64
boards. One adding a missing interrupt for the pin controller.

----------------------------------------------------------------
Icenowy Zheng (4):
      arm64: allwinner: a64: bananapi-m64: add missing ethernet0 alias
      arm64: allwinner: a64: pine64: add missing ethernet0 alias
      arm64: allwinner: a64: sopine: add missing ethernet0 alias
      arm64: allwinner: h5: fix pinctrl IRQs

 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts     | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts           | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi                  | 3 +++
 4 files changed, 6 insertions(+)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170818/13d1cd9e/attachment.sig>
