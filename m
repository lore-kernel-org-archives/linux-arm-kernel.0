From: yh.huang@mediatek.com (YH Huang)
Date: Thu, 21 May 2015 21:29:22 +0800
Subject: [PATCH v2 0/2] Add MediaTek display PWM driver
Message-ID: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

YH Huang (2):
  dt-bindings: pwm: add MediaTek display PWM bindings
  pwm: add MediaTek display PWM driver support

 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |  25 +++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-mtk-disp.c                         | 228 +++++++++++++++++++++
 4 files changed, 264 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
 create mode 100644 drivers/pwm/pwm-mtk-disp.c

--
1.8.1.1.dirty
