From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 29 Jun 2017 10:54:32 +0800
Subject: [PATCH 0/2] Add ZTE ZX PWM device driver support
Message-ID: <1498704874-14599-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

The series adds the dt-bindings document and device driver for PWM
controller found on ZTE ZX family SoCs.

Shawn Guo (2):
  dt-bindings: pwm: add bindings doc for ZTE ZX PWM controller
  pwm: add ZTE ZX PWM device driver

 Documentation/devicetree/bindings/pwm/pwm-zx.txt |  22 ++
 drivers/pwm/Kconfig                              |   9 +
 drivers/pwm/Makefile                             |   1 +
 drivers/pwm/pwm-zx.c                             | 244 +++++++++++++++++++++++
 4 files changed, 276 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-zx.txt
 create mode 100644 drivers/pwm/pwm-zx.c

-- 
1.9.1
