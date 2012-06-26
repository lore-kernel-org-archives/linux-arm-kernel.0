From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 16:58:07 +0800
Subject: [PATCH 0/4] pwm-mxs driver updates
Message-ID: <1340701091-8488-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series makes a few updates on pwm-mxs driver to make it better.

Shawn Guo (4):
  pwm: pwm-mxs: encode soc name in compatible string
  pwm: pwm-mxs: use global reset function stmp_reset_block
  pwm: pwm-mxs: use devm_* managed functions
  pwm: pwm-mxs: add pinctrl support

 Documentation/devicetree/bindings/pwm/mxs-pwm.txt |    4 +-
 drivers/pwm/pwm-mxs.c                             |   36 ++++++++++-----------
 2 files changed, 19 insertions(+), 21 deletions(-)

-- 
1.7.5.4
