From: javi.merino@arm.com (Javi Merino)
Date: Mon, 13 Jun 2016 16:15:13 +0100
Subject: [PATCH 0/2]  Enable SCPI sensors for Juno
Message-ID: <1465830915-16342-1-git-send-email-javi.merino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the ARM SCPI sensors in arm64 defconfig and add thermal zones
for the thermal scpi sensors on Juno.  The hwmon support for SCPI
sensors was merged for v4.4, this just enables it by default.

Javi Merino (2):
  arm64: defconfig: enable SENSORS_ARM_SCPI
  arm64: dts: juno: add thermal zones for scpi sensors

 arch/arm64/boot/dts/arm/juno-base.dtsi | 42 ++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-r1.dts    | 16 +++++++++++++
 arch/arm64/boot/dts/arm/juno-r2.dts    | 16 +++++++++++++
 arch/arm64/configs/defconfig           |  1 +
 4 files changed, 75 insertions(+)

-- 
1.9.1
