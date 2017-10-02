From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 2 Oct 2017 22:39:02 +0200
Subject: [PATCH 0/2] ARM-S3C64xx: Adjustments for samsung_bl_set()
Message-ID: <0b695686-2e07-910d-6278-91d54a1b0b2f@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 2 Oct 2017 22:34:56 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete two error messages for a failed memory allocation
  Delete an unnecessary return statement

 arch/arm/mach-s3c64xx/dev-backlight.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
2.14.2
