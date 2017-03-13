From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 13 Mar 2017 21:07:23 +0200
Subject: [PATCH v3 0/3] watchdog: s3c2410: Minor cleanups
Message-ID: <20170313190726.2988-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Continuation of cleanup of s3c2410-wdt driver.

Changes since v2:
=================
1. Address Guenter's comments about unneeded cast to const.

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  watchdog: s3c2410: Constify local structures
  watchdog: s3c2410: Simplify getting driver data
  watchdog: s3c2410: Minor code cleanup

 drivers/watchdog/s3c2410_wdt.c | 58 +++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

-- 
2.9.3
