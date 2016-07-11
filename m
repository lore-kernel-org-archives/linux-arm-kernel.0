From: weiqing.kong@mediatek.com (Weiqing Kong)
Date: Mon, 11 Jul 2016 16:18:06 +0800
Subject: [PATCH V2 0/3] Support Mediatek Soc MT2701 disp pwm
Message-ID: <1468225089-28576-1-git-send-email-weiqing.kong@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These series patches modify pwm-mtk-disp.c
and dts/dtsi config to support MT2701 disp pwm.

Changes since v1:
- Change dtsi compatible string "mediatek,mt2701-disp-bls" into "mediatek,mt2701-disp-pwm"
- Change some macros into struct mtk_pwm_data

Weiqing Kong (3):
  dt-bindings: pwm: Add MediaTek display PWM bindings
  pwm: Add MediaTek MT2701 display PWM driver support
  dts: Add disp bls dtsi and dts config for MT2701

 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |  3 +-
 arch/arm/boot/dts/mt2701-evb.dts                   | 29 +++++++
 arch/arm/boot/dts/mt2701.dtsi                      |  9 ++
 drivers/pwm/pwm-mtk-disp.c                         | 99 +++++++++++++++++-----
 4 files changed, 120 insertions(+), 20 deletions(-)

-- 
1.8.1.1.dirty
