From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 10 May 2010 23:43:11 +0300
Subject: [PATCH 2/5] MAINTAINERS: Add entry for HP iPAQ rx1950
In-Reply-To: <1273524194-13346-1-git-send-email-anarsoul@gmail.com>
References: <1273524194-13346-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1273524194-13346-3-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d5b0b1b..9f48b68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -890,6 +890,12 @@ F:	arch/arm/mach-rpc/
 F:	drivers/net/arm/ether*
 F:	drivers/scsi/arm/
 
+ARM/RX1950 (HP iPAQ rx1950) MACHINE SUPPORT
+M:	Vasily Khoruzhick <anarsoul@gmail.com>
+W:	http://handhelds.org/moin/moin.cgi/HpIpaqRx1950
+S:	Maintained
+F:	arch/arm/mach-s3c2440/mach-rx1950.c
+
 ARM/SHARK MACHINE SUPPORT
 M:	Alexander Schulz <alex@shark-linux.de>
 W:	http://www.shark-linux.de/shark.html
-- 
1.7.0.4
