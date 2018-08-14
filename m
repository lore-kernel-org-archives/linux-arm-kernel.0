From: julien.grall@arm.com (Julien Grall)
Date: Tue, 14 Aug 2018 11:33:32 +0100
Subject: [PATCH] Documentation/arm64/sve: Couple of improvements and typoes
Message-ID: <20180814103332.28836-1-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    - Fix mismatch between SVE registers (Z) and FPSIMD register (V)
    - Don't prefix the path for [3] with Linux to stay consistent with
    [1] and [2].

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 Documentation/arm64/sve.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/sve.txt b/Documentation/arm64/sve.txt
index f128f736b4a5..7169a0ec41d8 100644
--- a/Documentation/arm64/sve.txt
+++ b/Documentation/arm64/sve.txt
@@ -200,7 +200,7 @@ prctl(PR_SVE_SET_VL, unsigned long arg)
       thread.
 
     * Changing the vector length causes all of P0..P15, FFR and all bits of
-      Z0..V31 except for Z0 bits [127:0] .. Z31 bits [127:0] to become
+      Z0..Z31 except for Z0 bits [127:0] .. Z31 bits [127:0] to become
       unspecified.  Calling PR_SVE_SET_VL with vl equal to the thread's current
       vector length, or calling PR_SVE_SET_VL with the PR_SVE_SET_VL_ONEXEC
       flag, does not constitute a change to the vector length for this purpose.
@@ -500,7 +500,7 @@ References
 [2] arch/arm64/include/uapi/asm/ptrace.h
     AArch64 Linux ptrace ABI definitions
 
-[3] linux/Documentation/arm64/cpu-feature-registers.txt
+[3] Documentation/arm64/cpu-feature-registers.txt
 
 [4] ARM IHI0055C
     http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055c/IHI0055C_beta_aapcs64.pdf
-- 
2.11.0
