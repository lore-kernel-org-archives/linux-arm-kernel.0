From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Thu, 13 Nov 2014 10:05:30 +0530
Subject: [RESEND PATCH V2 0/2] Add I2C and enable M41T0M6 RTC
Message-ID: <cover.1415852424.git.bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C support on Colibri VFxx moduels and enable M41T0M6 RTC
available on Colibri carrier boards.

Bhuvanchandra DV (2):
  ARM: dts: vf-colibri: Add I2C support
  ARM: dts: vf-colibri-eval-v3.dts: Enable ST-M41T0M6 RTC

 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi |   12 +++++++++++-
 arch/arm/boot/dts/vf-colibri.dtsi         |   13 +++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

-- 
1.7.9.5
