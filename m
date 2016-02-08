From: j-keerthy@ti.com (Keerthy)
Date: Mon, 8 Feb 2016 14:46:27 +0530
Subject: [PATCH 0/3] arm: dts: DRA7: Add IVA and DSPEVE thermal domain data
Message-ID: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP5 has 3 thermal zones cpu, core and multimedia.
On the other hand DRA7 has 5 thermal zones cpu, gpu, core, dspeve
and iva. Currently cpu, core and multimedia are being added via dt
and the other 2 are getting added via kernel. Add the missing thermal
domains in dt so as give the correct trip numbers, type and temperatures.

Tested on DRA7-EVM.
 
Keerthy (3):
  arm: dts: DRA7: Add DSPEVE thermal data
  arm: dts: DRA7: Add IVA thermal data
  arm: dts: DRA7: Add missing IVA and DSPEVE thermal domain data

 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7-iva-thermal.dtsi    | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi                |  2 ++
 3 files changed, 56 insertions(+)
 create mode 100644 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
 create mode 100644 arch/arm/boot/dts/dra7-iva-thermal.dtsi

-- 
1.9.1
