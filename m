From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 18 Dec 2017 17:52:02 +0000
Subject: [PATCH v2 0/6] Add PWM and TPU support to r8a7743
Message-ID: <1513619528-12060-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

this series includes all that is required to add PWM and TPU SoC specific
support for the r8a7743.

Thanks,

Fabrizio Castro (6):
  ARM: shmobile: defconfig: Enable PWM
  dt-bindings: pwm: rcar: Document r8a774[35] PWM bindings
  ARM: dts: r8a7743: Add PWM SoC support
  dt-bindings: pwm: renesas-tpu: Document r8a774[35] support
  pinctrl: sh-pfc: r8a7791: Add tpu groups and function
  ARM: dts: r8a7743: Add TPU support

 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   | 10 ++-
 .../devicetree/bindings/pwm/renesas,tpu-pwm.txt    |  4 +-
 arch/arm/boot/dts/r8a7743.dtsi                     | 87 ++++++++++++++++++++++
 arch/arm/configs/shmobile_defconfig                |  1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               | 42 ++++++++++-
 5 files changed, 138 insertions(+), 6 deletions(-)

-- 
2.7.4
