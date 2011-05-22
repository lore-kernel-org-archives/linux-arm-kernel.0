From: green@linuxhacker.ru (green at linuxhacker.ru)
Date: Sun, 22 May 2011 17:04:36 -0400
Subject: [PATCH 3/3] Update Nook Color machine 3284 to common Encore name.
In-Reply-To: <1306098276-21112-1-git-send-email-green@linuxhacker.ru>
References: <1306098276-21112-1-git-send-email-green@linuxhacker.ru>
Message-ID: <1306098276-21112-4-git-send-email-green@linuxhacker.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleg Drokin <green@linuxhacker.ru>

Nachine database already updated:
http://www.arm.linux.org.uk/developer/machines/list.php?id=3284

Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
---
 arch/arm/tools/mach-types |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 7ca41f0..2f0db3e 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -962,7 +962,7 @@ omapl138_case_a3	MACH_OMAPL138_CASE_A3	OMAPL138_CASE_A3	3280
 uemd			MACH_UEMD		UEMD			3281
 ccwmx51mut		MACH_CCWMX51MUT		CCWMX51MUT		3282
 rockhopper		MACH_ROCKHOPPER		ROCKHOPPER		3283
-nookcolor		MACH_NOOKCOLOR		NOOKCOLOR		3284
+encore			MACH_ENCORE		ENCORE			3284
 hkdkc100		MACH_HKDKC100		HKDKC100		3285
 ts42xx			MACH_TS42XX		TS42XX			3286
 aebl			MACH_AEBL		AEBL			3287
-- 
1.7.4.4
