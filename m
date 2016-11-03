From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  3 Nov 2016 10:11:22 +0100
Subject: [PATCH 0/2] ARM64: meson-gxbb: SCPI Fixup
Message-ID: <1478164284-24958-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset updates the GXBB dtsi and the ARM64 defconfig in order
to make SCPI work following the Legacy SCPI rework from Sudeep Hola at [1].

The rework introduced a generic "arm,legacy-scpi" compatible string.
The second patch enables the necessary Platform MHU in defconfig.

[1] http://lkml.kernel.org/r/1478148731-11712-1-git-send-email-sudeep.holla at arm.com

Neil Armstrong (2):
  ARM64: dts: meson-gxbb: Add generic legacy scpi compatible
  ARM64: configs: Add Platform MHU in defconfig

 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 2 +-
 arch/arm64/configs/defconfig                | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
1.9.1
