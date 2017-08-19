From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 19 Aug 2017 16:06:39 +0800
Subject: [GIT PULL 3/4] Allwinner dts changes for 4.14, round 2
Message-ID: <20170819080639.y2umtabkspdft7if@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here's the second batch of Allwinner device tree changes for 4.14.
This is based on the previous pull request that is already in arm-soc.

I might send a late pull request for a single new board next week.
The board dts was posted only 2 days ago, so I'd like to wait a few
more days for feedback.

Thanks
ChenYu


The following changes since commit 581ae76e96c6ab3bf942da7c4822ce9fa2074a01:

  ARM: dts: sun8i: a83t: h8homlet: Enable micro-SD card and onboard eMMC (2017-08-05 22:06:58 +0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-4.14-2

for you to fetch changes up to 75ce73fdadf6944d6948f45b34cbfd7aa01190cc:

  ARM: sun8i: a83t: h8homlet-v2: Enable USB ports (2017-08-19 00:25:25 +0800)

----------------------------------------------------------------
Allwinner device tree changes for 4.14, round 2

The usual improvements:

  - AXP813/AXP818 PMIC (mfd and codec) enabled for Allwinner A83T boards

  - USB enabled for Allwinner A83T boards

----------------------------------------------------------------
Chen-Yu Tsai (9):
      ARM: sun8i: a83t: Add device node and pinmux setting for RSB controller
      ARM: sun8i: a83t: cubietruck-plus: Enable PMIC part of AXP818 PMIC
      ARM: sun8i: a83t: cubietruck-plus: Enable AC100 combo chip in AXP818 PMIC
      ARM: sun8i: a83t: h8homlet-v2: Enable PMIC part of AXP818 PMIC
      ARM: sun8i: a83t: h8homlet-v2: Enable AC100 combo chip in AXP818 PMIC
      ARM: sun8i: a83t: Add USB PHY and host device nodes
      ARM: sun8i: a83t: Add device node for USB OTG controller
      ARM: sun8i: a83t: cubietruck-plus: Enable onboard USB peripherals
      ARM: sun8i: a83t: h8homlet-v2: Enable USB ports

 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  | 64 ++++++++++++++
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   | 84 ++++++++++++++++--
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 99 ++++++++++++++++++++++
 3 files changed, 242 insertions(+), 5 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170819/2c20dba3/attachment.sig>
