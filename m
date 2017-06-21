From: zhi.mao@mediatek.com (Zhi Mao)
Date: Wed, 21 Jun 2017 16:11:08 +0800
Subject: [PATCH RESEND 0/4] mediatek: pwm driver add MT2712/MT7622 support 
Message-ID: <1498032672-7172-1-git-send-email-zhi.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pwm driver add MT2712/MT7622 support, fix clock control issue.
dtsi file will be upload latter, after the clock define is ready.

Zhi Mao (4):
  pwm: kconfig: modify mediatek information
  pwm: mediatek: fix clk issue
  pwm: bindings: add MT2712/MT7622 information
  pwm: mediatek: add MT2712/MT7622 support

 .../devicetree/bindings/pwm/pwm-mediatek.txt       |    6 +-
 drivers/pwm/Kconfig                                |    2 +-
 drivers/pwm/pwm-mediatek.c                         |  132 ++++++++++++++------
 3 files changed, 100 insertions(+), 40 deletions(-)
