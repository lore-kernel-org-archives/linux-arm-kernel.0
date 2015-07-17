From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 17 Jul 2015 10:17:56 +0200
Subject: [PATCH 0/2] MAINTAINERS: update max77686 entry and add one for
 max77802
Message-ID: <1437121078-26409-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee,

This series update the max77686 pmic drivers entry to also resolve the new
max77686 regulator DT binding doc and also adds an entry for the max77802.

The series depend on:

[PATCH v2 0/4] mfd: Improve DT binding docs for max77686 and max77802
https://lkml.org/lkml/2015/7/17/73


Javier Martinez Canillas (2):
  MAINTAINERS: add Device Tree binding doc for max77686 regulator
  MAINTAINERS: add an entry for the Maxim MAX77802 PMIC drivers

 MAINTAINERS | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.4.3
