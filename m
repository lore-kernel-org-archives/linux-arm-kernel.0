From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 12 Aug 2017 12:19:42 +0200
Subject: [PATCH V2 0/2] pwm: bcm2835: Support for polarity setting via DT
Message-ID: <1502533184-15765-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the third (optional) pwm cell to specify the
polarity.

Changes in V2:
* add ack and review tags

Stefan Wahren (2):
  dt-bindings: pwm-bcm2835: Increase pwm-cells
  pwm: bcm2835: Support for polarity setting via DT

 Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt | 4 ++--
 drivers/pwm/pwm-bcm2835.c                             | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.7.4
