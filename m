From: linucherian@gmail.com (linucherian at gmail.com)
Date: Tue, 11 Apr 2017 20:12:45 +0530
Subject: [RFC PATCH 7/7] arm64: Documentation: Add Cavium ThunderX2 SMMUv3
 erratas.
In-Reply-To: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
Message-ID: <1491921765-29475-8-git-send-email-linucherian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linu Cherian <linu.cherian@cavium.com>

Add Cavium ThunderX2 SMMUv3 erratas to the errata list.

Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
---
 Documentation/arm64/silicon-errata.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 10f2ddd..42422f6 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -62,6 +62,8 @@ stable kernels.
 | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154        |
 | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
 | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
+| Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
+| Cavium         | ThunderX2 SMMUv3| #126            | N/A                         |
 |                |                 |                 |                             |
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 |                |                 |                 |                             |
-- 
1.9.1
