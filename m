From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Thu, 28 Jul 2016 09:36:35 +0000
Subject: [PATCH v2 0/7] power: act8945a_charger: Improvements
In-Reply-To: <1467076970-12206-1-git-send-email-wenyou.yang@atmel.com>
References: <1467076970-12206-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641018CCCBFB3@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone

Do you have any comments for this patch set?

Best Regards,
Wenyou Yang
________________________________________
From: Wenyou Yang [wenyou.yang at atmel.com]
Sent: Tuesday, June 28, 2016 9:22
To: Sebastian Reichel; Dmitry Eremin-Solenikov; David Woodhouse; Rob Herring; Pawel Moll; Mark Brown; Ian Campbell; Kumar Gala
Cc: linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Ferre, Nicolas; linux-pm at vger.kernel.org; Yang, Wenyou
Subject: [PATCH v2 0/7] power: act8945a_charger: Improvements

This patch series is used to improve the act8945a-charger, such as
improve the way to check the status, fix the power supply type
property, add the status change update, and add more properties:
capacity level property and max current property.

Changes in v2:
 - Add missing ret declaration.

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
