From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 2 Oct 2017 19:56:56 +0200
Subject: [PATCH 0/6] ARM-S3C24xx: Adjustments for four function implementations
Message-ID: <d2ae00c8-da57-9ffc-3692-67ed6daa95e0@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 2 Oct 2017 19:50:05 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (6):
  Delete an error message for a failed memory allocation in s3c2410_iotiming_get()
  Improve a size determination in s3c2410_iotiming_get()
  s3c2410: Fix a typo in a comment line
  Delete an error message for a failed memory allocation in s3c2412_iotiming_get()
  Improve a size determination in s3c2412_iotiming_get()
  s3c2412: Fix a typo in a comment line

 arch/arm/mach-s3c24xx/iotiming-s3c2410.c | 8 +++-----
 arch/arm/mach-s3c24xx/iotiming-s3c2412.c | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

-- 
2.14.2
