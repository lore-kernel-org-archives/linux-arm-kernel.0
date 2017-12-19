From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 19 Dec 2017 13:34:55 +0000
Subject: [PATCH v3 0/5] Add PWM and TPU support to r8a7743
Message-ID: <1513690500-12165-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

this series includes all that is required to add PWM and TPU SoC specific
support for the r8a7743.

Thanks,

Fabrizio Castro (5):
  ARM: shmobile: defconfig: Enable PWM
  dt-bindings: pwm: rcar: Document r8a774[35] PWM bindings
  ARM: dts: r8a7743: Add PWM SoC support
  dt-bindings: pwm: renesas-tpu: Document r8a774[35] support
  ARM: dts: r8a7743: Add TPU support

 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   | 10 ++-
 .../devicetree/bindings/pwm/renesas,tpu-pwm.txt    |  4 +-
 arch/arm/boot/dts/r8a7743.dtsi                     | 80 ++++++++++++++++++++++
 arch/arm/configs/shmobile_defconfig                |  1 +
 4 files changed, 91 insertions(+), 4 deletions(-)

-- 
2.7.4
