From: abelvesa@linux.com (Abel Vesa)
Date: Tue,  6 Dec 2016 17:06:03 +0000
Subject: [PATCH 3/7] arm: module: Add apply_relocate_add
In-Reply-To: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
References: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
Message-ID: <1481043967-15602-4-git-send-email-abelvesa@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was only added to fix compiler error. It is not implemented
yet.

Signed-off-by: Abel Vesa <abelvesa@linux.com>
---
 arch/arm/kernel/module.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 4f14b5c..bf94922 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -52,6 +52,15 @@ void *module_alloc(unsigned long size)
 #endif
 
 int
+apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
+		   unsigned int symindex, unsigned int relindex,
+		   struct module *module)
+{
+	/* Not implemented yet */
+	return 0;
+}
+
+int
 apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 	       unsigned int relindex, struct module *module)
 {
-- 
2.7.4
