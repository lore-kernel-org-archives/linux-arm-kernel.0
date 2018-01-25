From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 25 Jan 2018 22:02:14 +0530
Subject: [PATCH 0/2] Add DTS for SDM845 SoC and MTP
Message-ID: <20180125163216.29018-1-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have serial[1], pinctrl[2] and clock[3]
drivers for SDM845 SoC out on the lists, heres the
basic dts files needed to boot a SDM845 based MTP
board to a ramfs based serial console shell.

[1] https://patchwork.ozlabs.org/cover/860251/
[2] https://patchwork.kernel.org/patch/10157143/
[3] https://lkml.org/lkml/2018/1/22/78

Rajendra Nayak (2):
  arm64: dts: sdm845: Add minimal dts/dtsi files for sdm845 SoC and MTP
  arm64: dts: sdm845: Add serial console support

 arch/arm64/boot/dts/qcom/Makefile         |   1 +
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts   |  13 ++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi  |  14 ++
 arch/arm64/boot/dts/qcom/sdm845-pins.dtsi |  32 +++
 arch/arm64/boot/dts/qcom/sdm845.dtsi      | 330 ++++++++++++++++++++++++++++++
 5 files changed, 390 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
