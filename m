From: stefan@agner.ch (stefan at agner.ch)
Date: Tue, 13 May 2014 19:27:37 +0200
Subject: [PATCH 0/2] ARM: tegra: initial support for Colibri T30
Message-ID: <cover.1400001937.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Agner <stefan@agner.ch>

This patches cooked a while in our repository and is now quite
complete. All is tested on several Colibri T30 modules and
evaluation boards by Marcel and me. The device tree is splitted
into a module part and the carrier board. The former is then
included by the latter (in this case the evaluation board). The
comments "Colibri: " represent the SO-DIMM Pin name as defined
in the Colibri standard, and should be helpful for users
adopting the device tree for other carrier boards.

Stefan Agner (2):
  ARM: tegra: enable MCP251x CAN controller and DS1307 RTC
  ARM: tegra: initial add of Colibri T30

 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 202 ++++++++++++++
 arch/arm/boot/dts/tegra30-colibri.dtsi        | 375 ++++++++++++++++++++++++++
 arch/arm/configs/tegra_defconfig              |   6 +
 4 files changed, 584 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/tegra30-colibri.dtsi

-- 
1.9.2
