From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Jun 2017 22:23:16 +0200
Subject: [GIT PULL] Allwinner H3 changes for 4.13
Message-ID: <20170614202316.3tsepyo52tb4spw6@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This time again, due to the shared DTSI between the H3 and H5, we had
to create a common branch shared by both arm and arm64 (commits up to
0eba511a3cac).

This one is built on top of that common branch and the H5 will be
built the same way.

Thanks!
Maxime

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-h3-for-4.13

for you to fetch changes up to 7a78ef92cdc5813cab2c3a8ca2334eaaedc6818c:

  ARM: sun8i: h3: Enable EMAC with external PHY on Orange Pi Plus 2E (2017-06-10 11:24:39 +0200)

----------------------------------------------------------------
Allwinner H3 changes for 4.13

This tag is about bringing the EMAC support to the H3 boards.

----------------------------------------------------------------
Chen-Yu Tsai (2):
      ARM: sunxi: h3-h5: Convert R_CCU raw numbers to macros
      ARM: sun8i: h3: Enable EMAC with external PHY on Orange Pi Plus 2E

Corentin Labbe (10):
      arm: sun8i: sunxi-h3-h5: Add dt node for the syscon control module
      arm: sun8i: sunxi-h3-h5: add dwmac-sun8i ethernet driver
      arm: sun8i: orangepi-pc: Enable dwmac-sun8i
      arm: sun8i: orangepi-one: Enable dwmac-sun8i
      arm: sun8i: orangepi-2: Enable dwmac-sun8i
      arm: sun8i: orangepi-pc-plus: Set EMAC activity LEDs to active high
      arm: sun8i: nanopi-neo: Enable dwmac-sun8i
      ARM: sun8i: orangepi-plus: Enable dwmac-sun8i
      ARM: sun8i: bananapi-m2-plus: Enable dwmac-sun8i
      arm: sun8i: orangepi-zero: Enable dwmac-sun8i

 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts |  8 ++++
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts   | 29 ++++++++++++++
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts         |  7 ++++
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts         |  8 ++++
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts       |  8 ++++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts   |  5 +++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts        |  8 ++++
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts      | 32 +++++++++++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts    | 26 ++++++++++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                | 48 +++++++++++++++++++++--
 10 files changed, 176 insertions(+), 3 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170614/bd854d67/attachment.sig>
