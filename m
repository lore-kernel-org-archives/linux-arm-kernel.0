From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Sun, 11 Nov 2018 23:26:29 +0100
Subject: PCIe support in APQ8098-based board
Message-ID: <44260aa9-d01a-f9a5-a2e6-31f06de48d34@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm playing with an APQ8098-based board, which I got to boot an upstream
v4.20-rc1 kernel to the command line, by reusing the msm8998-mtp.dts
(IIUC apq8098 is the msm8998's "little brother", in that they are
almost the same SoC, with some HW blocks missing in the apq8098).

I'm trying to get PCIe working on my eval board. I'm wondering if
someone from qcom, codeaurora, or linaro has perhaps already done
this work, and it's just not upstream yet?

There seem to be proper drivers for the RC and the PHY, but some
low-level stuff are missing (clocks, regulator, power domain).

drivers/pci/controller/dwc/pcie-qcom.c
drivers/phy/qualcomm/phy-qcom-qmp.c

Regards.
