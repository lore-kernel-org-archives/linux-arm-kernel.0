From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Fri, 19 Sep 2014 19:08:50 +0530
Subject: [PATCH v2 0/2] Add PWM and backlight support for Colibri VF61 modules
Message-ID: <cover.1411130205.git.bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
[1] Sorted the node names alphabetically.
[2] Updated the node name 'bl: backlight' to 'backlight: bl'.
[3] Dropped the leading space in 'pwm-names' property of backlight.

Bhuvanchandra DV (2):
  ARM: dts: vf610-colibri: Add PWM support
  ARM: dts: vf610-colibri: Add backlight support

 arch/arm/boot/dts/vf610-colibri-eval-v3.dts |   14 ++++++++++++
 arch/arm/boot/dts/vf610-colibri.dtsi        |   33 +++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

-- 
1.7.9.5
