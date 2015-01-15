From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 Jan 2015 11:47:04 +0100
Subject: [PATCH v3 3/5] MAINTAINERS: Add the RTC driver for the Armada38x
In-Reply-To: <1421318826-27268-1-git-send-email-gregory.clement@free-electrons.com>
References: <1421318826-27268-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1421318826-27268-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Put it in the mvebu entry.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddb9ac8d32b3..393f158a64e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1157,6 +1157,7 @@ M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-mvebu/
+F:	drivers/rtc/armada38x-rtc
 
 ARM/Marvell Berlin SoC support
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
-- 
1.9.1
