From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 24 Jun 2016 15:17:33 +0800
Subject: [PATCH 0/7] power: act8945a_charger: Improvements
Message-ID: <1466752660-2922-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is used to improve the act8945a-charger, such as
improve the way to check the status, fix the power supply type
property, add the status change update, and add more properties:
capacity level property and max current property.


Wenyou Yang (7):
  power: act8945a_charger: Remove "battery_temperature"
  power: act8945a_charger: Improve
  power: act8945a_charger: Add status change update support
  power: act8945a_charger: Fix the power supply type
  power: act8945a_charger: Add capacity level property
  power: act8945a_charger: Add max current property
  doc: bindings: act8945a-charger: Update properties

 .../devicetree/bindings/power/act8945a-charger.txt |   6 +-
 drivers/power/act8945a_charger.c                   | 371 ++++++++++++++++++---
 2 files changed, 337 insertions(+), 40 deletions(-)

-- 
2.7.4
