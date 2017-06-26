From: tyzhang@actions-semi.com (=?utf-8?B?5byg5aSp55uK?=)
Date: Mon, 26 Jun 2017 14:56:41 +0800
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjUgMTMvMjZdIE1BSU5UQUlORVJT?=
 =?utf-8?B?OiBBZGQgQWN0aW9ucyBTZW1pIE93bCBzZWN0aW9u?=
In-Reply-To: <20170619024443.10487-1-afaerber@suse.de>
References: <c68b8edf-9609-0147-6eeb-83793dc3adef@suse.de>
 <20170619024443.10487-1-afaerber@suse.de>
Message-ID: <5EBFE11104EFEA4981C19EC8D2C2946B05202052@srv-mail-02.actions.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+c

-----????-----
???: Andreas F?rber [mailto:afaerber at suse.de] 
????: 2017?6?19? 10:45
???: linux-arm-kernel at lists.infradead.org
??: mp-cs; Thomas Liau; ???; ??; ???; 96boards at ucrobotics.com; support at lemaker.org; linux-kernel at vger.kernel.org; Andreas F?rber
??: [PATCH v5 13/26] MAINTAINERS: Add Actions Semi Owl section

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v4 -> v5:
 * Updated arm dts file pattern
 * Added clocksource file patterns
 
 v2 -> v3 -> v4: unchanged
 
 v2: new
 
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d56524402f36..831bfd5cc68b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1036,6 +1036,18 @@ S:	Maintained
 F:	drivers/amba/
 F:	include/linux/amba/bus.h
 
+ARM/ACTIONS SEMI ARCHITECTURE
+M:	Andreas F?rber <afaerber@suse.de>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+N:	owl
+F:	arch/arm/mach-actions/
+F:	arch/arm/boot/dts/owl-*
+F:	arch/arm64/boot/dts/actions/
+F:	drivers/clocksource/owl-*
+F:	Documentation/devicetree/bindings/arm/actions.txt
+F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
+
 ARM/ADS SPHERE MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
2.12.3
