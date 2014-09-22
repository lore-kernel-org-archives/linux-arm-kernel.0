From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Mon, 22 Sep 2014 15:38:10 +0530
Subject: [PATCH v3 0/2] Add PWM and backlight support for Colibri VF61 modules
Message-ID: <cover.1411378369.git.bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
[1] Droped the changes done in the root node.
[2] Fix typo in backlight node.

Bhuvanchandra DV (2):
  ARM: dts: vf610-colibri: Add PWM support
  ARM: dts: vf610-colibri: Add backlight support

 arch/arm/boot/dts/vf610-colibri-eval-v3.dts |   14 +++++++++++++
 arch/arm/boot/dts/vf610-colibri.dtsi        |   29 +++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

-- 
1.7.9.5
