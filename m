From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 17 Aug 2017 18:31:41 +0100
Subject: [PATCH 0/2] ARM: dtsi: r8a7745: iwg22m: Add eMMC support
Message-ID: <1502991103-2325-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds eMMC support to r8a7745 SoC and iW-RainboW-G22M-SM SoM.

Testing has been made on top of Renesas's devel branch.

The patches contained in this series depend on the following patches:
[1/2] ARM: dts: iwg22m: Add iWave RZG1E SODIMM SOM - https://patchwork.kernel.org/patch/9901619/
[2/2] ARM: dts: iwg22d-sodimm: Add support for iWave G22D-SODIMM board - https://patchwork.kernel.org/patch/9901623/
dt-bindings: mmc: sh_mmcif: Document r8a7745 DT bindings - https://patchwork.kernel.org/patch/9902199/

Regards,

Fabrizio Castro (2):
  ARM: dts: r8a7745: Add MMC interface support
  ARM: dtsi: iwg22m: Add eMMC support

 arch/arm/boot/dts/r8a7745-iwg22m.dtsi | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7745.dtsi        | 16 ++++++++++++++++
 2 files changed, 42 insertions(+)

-- 
2.7.4
