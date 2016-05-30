From: weiqing.kong@mediatek.com (Weiqing Kong)
Date: Mon, 30 May 2016 16:41:49 +0800
Subject: [PATCH RESEND 0/3] Support Mediatek Soc MT2701 disp pwm
Message-ID: <1464597712-5399-1-git-send-email-weiqing.kong@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for sending many times, because of company
permission settings, many people and groups can't
receive these patches before.

These series patches modify pwm-mtk-disp.c
and dts/dtsi config to support MT2701 disp pwm.

Weiqing Kong (3):
  dt-bindings: pwm: Add MediaTek display PWM bindings
  pwm: Add MediaTek MT2701 display PWM driver support
  dts: Add disp bls dsti and dts config for MT2701

 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |  5 +-
 arch/arm/boot/dts/mt2701-evb.dts                   | 29 +++++++
 arch/arm/boot/dts/mt2701.dtsi                      |  9 +++
 drivers/pwm/pwm-mtk-disp.c                         | 89 +++++++++++++++++-----
 4 files changed, 113 insertions(+), 19 deletions(-)

-- 
1.8.1.1.dirty
