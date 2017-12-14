From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 14 Dec 2017 10:57:02 +0000
Subject: [PATCH 0/4] Add PWM and TPU support to r8a7745
Message-ID: <1513249026-26759-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

this series includes all that is required to add PWM and TPU SoC specific
support for the r8a7745.

Thanks,

Fabrizio Castro (4):
  pinctrl: sh-pfc: r8a7794: Add PWM[0123456] support
  ARM: dts: r8a7745: Add PWM SoC support
  pinctrl: sh-pfc: r8a7794: Add tpu groups and function
  ARM: dts: r8a7745: Add TPU support

 arch/arm/boot/dts/r8a7745.dtsi       |  87 ++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 266 +++++++++++++++++++++++++++++++++++
 2 files changed, 353 insertions(+)

-- 
2.7.4
