From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 11 Mar 2014 07:51:16 +0900
Subject: [PATCH v2 0/3] arm64: add new support Samsung GH7 SoC and SSDK board
Message-ID: <1394491879-5320-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for Samsung ARMv8 core based GH7 SoC and its evaluation SSDK
board.

Changes since v1:
- remove model and compatible in dtsi
- remove inclusion /dts-v1/ in dtsi
- add aliase for serial0
- remove compatible cortex-a9-gic for gic
- remove clock-frequncy for timer
- change number of address-cells and size-cells to 2
- enable ARCH_GH7 in single defconfig for arm64

There were many comments for SoC vendor's Kconfig entry but now I have no
choice except adding ARCH_GH7 and enabling it in current single defconfig
for arm64 by default.

[PATCH v2 1/3] arm64: dts: add initial dts for Samsung GH7 SoC and SSDK-GH7 board
[PATCH v2 2/3] arm64: defconfig: Enable ARCH_GH7 by default
[PATCH v2 3/3] Documentation: DT: add new entry for Samsung GH7 SoC and SSDK board
