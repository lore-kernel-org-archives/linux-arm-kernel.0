From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 4 Oct 2017 13:10:44 +0200
Subject: [PATCH 0/2] ARM-SAMSUNG: Adjustments for 14 function implementations
Message-ID: <75c352ad-c51e-2e63-2f93-0f14522ff09c@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 4 Oct 2017 12:48:24 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in three functions
  Improve a size determination in 13 functions

 arch/arm/plat-samsung/adc.c          | 12 ++++--------
 arch/arm/plat-samsung/devs.c         | 33 +++++++++++----------------------
 arch/arm/plat-samsung/platformdata.c |  4 +---
 3 files changed, 16 insertions(+), 33 deletions(-)

-- 
2.14.2
