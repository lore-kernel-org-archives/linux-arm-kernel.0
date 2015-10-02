From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri,  2 Oct 2015 15:47:45 -0500
Subject: [PATCH 7/7] Document the use of the arm64 contpte/nonconpte flags.
In-Reply-To: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
References: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1443818865-19846-8-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These flags allow the user to enable/disable the contiguous PTE
detection and marking on the kernel command line for
debugging purposes.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 Documentation/kernel-parameters.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 22a4b68..2766290 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -744,6 +744,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			seconds. Defaults to 10*60 = 10mins. A value of 0
 			disables the blank timer.
 
+	contpte		[ARM64] Enable contiguous PTE marking for the kernel
+			linear range. This may be disabled with nocontpte.
+			Default: Enabled
+
 	coredump_filter=
 			[KNL] Change the default value for
 			/proc/<pid>/coredump_filter.
-- 
2.4.3
