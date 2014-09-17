From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Wed, 17 Sep 2014 13:46:27 +0530
Subject: [PATCH 0/3] Add PWM and backlight support for Colibri VF61 modules
Message-ID: <cover.1410930820.git.bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabled pwm second instance and backlight control

Bhuvanchandra DV (3):
  ARM: dts: vf610: Add PWM second instance
  ARM: dts: vf610-colibri: Add PWM support
  ARM: dts: vf610-colibri: Add backlight support

 arch/arm/boot/dts/vf610-colibri-eval-v3.dts |   14 ++++++++++++
 arch/arm/boot/dts/vf610-colibri.dtsi        |   32 +++++++++++++++++++++++++++
 arch/arm/boot/dts/vf610.dtsi                |   13 +++++++++++
 3 files changed, 59 insertions(+)

-- 
1.7.9.5
