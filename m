From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 15 Mar 2018 19:36:37 +0800
Subject: [GIT PULL 3/6] i.MX device tree updates with new clock for 4.17
In-Reply-To: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
References: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1521113800-16401-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

To resolve the dependency on those new clock IDs, this pull request is
built on top of tag clk-imx-4.17-newid, which has been merged into clk
tree.

Shawn


The following changes since commit 1691cc375a39d13a70829cabdd87ca9116a16907:

  clk: imx: imx7d: add the Keypad Port module clock (2018-02-28 14:43:00 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-newclk-4.17

for you to fetch changes up to 303aa1bf077711248bd5a75cab3f7355cad8c264:

  ARM: dts: imx7s: add Keypad Port module (2018-02-28 14:58:44 +0800)

----------------------------------------------------------------
i.MX device tree update with new clock for 4.17:
 - Add CAAM and Keypad device node for i.MX7S/D SoC device tree.
 - Add clock support for i.MX7 SNVS RTC device.

----------------------------------------------------------------
Anson Huang (1):
      ARM: dts: imx7s: add snvs rtc clock

Rui Miguel Silva (1):
      ARM: dts: imx7s: add CAAM device node

Stefan Agner (1):
      ARM: dts: imx7s: add Keypad Port module

 .../devicetree/bindings/crypto/fsl-sec4.txt        | 17 +++++++++
 arch/arm/boot/dts/imx7s.dtsi                       | 40 ++++++++++++++++++++++
 2 files changed, 57 insertions(+)
