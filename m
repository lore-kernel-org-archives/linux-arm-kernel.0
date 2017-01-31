From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 Jan 2017 12:19:55 +0000
Subject: [PATCH 6/7] arm64: arch_timer: document Hisilicon erratum 161010101
In-Reply-To: <1485865196-12742-1-git-send-email-mark.rutland@arm.com>
References: <1485865196-12742-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1485865196-12742-7-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ding Tianhong <dingtianhong@huawei.com>

Now that we have a workaround for Hisilicon erratum 161010101, notes
this in the arm64 silicon-errata document.

The new config option is too long to fit in the existing kconfig column,
so this is widened to accomodate it.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
[Mark: split patch, reword commit message]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/arm64/silicon-errata.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 4a5e6cc..e12c926 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -63,3 +63,5 @@ stable kernels.
 | Cavium         | ThunderX SMMUv2 | #27704          | N/A                              |
 |                |                 |                 |                                  |
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585              |
+|                |                 |                 |                                  |
+| Hisilicon      | Hip0{5,6,7}     | #161010101      | HISILICON_ERRATUM_161010101      |
-- 
1.9.1
