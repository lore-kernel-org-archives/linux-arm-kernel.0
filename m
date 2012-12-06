From: linux-arm@overkiz.com (Boris BREZILLON)
Date: Thu,  6 Dec 2012 17:45:22 +0100
Subject: [PATCH 0/1] pwm: atmel: TCB pwm driver
Message-ID: <cover.1354810562.git.linux-arm@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch adds support for Timer Counter Block PWM.
TCB PWM chip provides 6 pwm devices.
This PWM devices are grouped by 2 (0/1, 2/3 and 4/5).
The PWM devices in a given group must use the same period_ns value.


Regards,

Boris

--
Boris BREZILLON (1):
  pwm: atmel: add Timer Counter Block PWM driver

 .../devicetree/bindings/pwm/atmel-tcb-pwm.txt      |   15 +
 drivers/pwm/Kconfig                                |    8 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-atmel-tcb.c                        |  335 ++++++++++++++++++++
 4 files changed, 359 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
 create mode 100644 drivers/pwm/pwm-atmel-tcb.c
