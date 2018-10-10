From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Oct 2018 17:25:51 +0100
Subject: [PATCH] arm64: Add silicon-errata.txt entry for ARM erratum 1188873
Message-ID: <20181010162551.104107-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document that we actually work around ARM erratum 1188873

Fixes: 95b861a4a6d9 ("arm64: arch_timer: Add workaround for ARM erratum 1188873")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm64/silicon-errata.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 3b2f2dd82225..76ccded8b74c 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -56,6 +56,7 @@ stable kernels.
 | ARM            | Cortex-A72      | #853709         | N/A                         |
 | ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_858921        |
 | ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024718       |
+| ARM            | Cortex-A76      | #1188873        | ARM64_ERRATUM_1188873       |
 | ARM            | MMU-500         | #841119,#826419 | N/A                         |
 |                |                 |                 |                             |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
-- 
2.19.1
