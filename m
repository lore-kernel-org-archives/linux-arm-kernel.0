From: will.deacon@arm.com (Will Deacon)
Date: Mon,  1 Oct 2018 15:24:48 +0100
Subject: [PATCH 2/2] arm64: docs: Document SSBS HWCAP
In-Reply-To: <1538403888-13277-1-git-send-email-will.deacon@arm.com>
References: <1538403888-13277-1-git-send-email-will.deacon@arm.com>
Message-ID: <1538403888-13277-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We advertise the MRS/MSR instructions for toggling SSBS at EL0 using an
HWCAP, so document it along with the others.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 Documentation/arm64/elf_hwcaps.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/arm64/elf_hwcaps.txt b/Documentation/arm64/elf_hwcaps.txt
index 51ccfab408cc..ea819ae024dd 100644
--- a/Documentation/arm64/elf_hwcaps.txt
+++ b/Documentation/arm64/elf_hwcaps.txt
@@ -178,3 +178,7 @@ HWCAP_ILRCPC
 HWCAP_FLAGM
 
     Functionality implied by ID_AA64ISAR0_EL1.TS == 0b0001.
+
+HWCAP_SSBS
+
+    Functionality implied by ID_AA64PFR1_EL1.SSBS == 0b0010.
-- 
2.1.4
