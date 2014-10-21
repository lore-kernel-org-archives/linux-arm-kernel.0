From: nm@ti.com (Nishanth Menon)
Date: Tue, 21 Oct 2014 09:30:45 -0500
Subject: [PATCH 0/3] ARM: dts: dra72-evm: Add MMC PMIC button information
Message-ID: <1413901848-32268-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series is based on 3.18-rc1 and enables palmas power button and
MMC (SD/EMMC) support. These could be queued for 3.19-rc1 considering
that these are not fixes, if it is not too late for additional
features for dts, might be nice to get them merged for 3.18 series.

Menon, Nishanth (1):
  ARM: dts: dra72-evm: Add MMC nodes

Nishanth Menon (2):
  ARM: dts: dra72-evm: Provide explicit pinmux for TPS PMIC
  ARM: dts: dra72-evm: Add power button node

 arch/arm/boot/dts/dra72-evm.dts |   76 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

-- 
1.7.9.5

Regards,
Nishanth Menon
