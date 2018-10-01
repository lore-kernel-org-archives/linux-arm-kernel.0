From: will.deacon@arm.com (Will Deacon)
Date: Mon,  1 Oct 2018 15:24:47 +0100
Subject: [PATCH 1/2] arm64: docs: Fix typos in ELF hwcaps
In-Reply-To: <1538403888-13277-1-git-send-email-will.deacon@arm.com>
References: <1538403888-13277-1-git-send-email-will.deacon@arm.com>
Message-ID: <1538403888-13277-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Giacomo Travaglini <Giacomo.Travaglini@arm.com>

Fix some typos in our hwcap documentation, where we refer to the wrong
ID register for some of the capabilities.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Giacomo Travaglini <giacomo.travaglini@arm.com>
[will: fix amusing binary constants]
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 Documentation/arm64/elf_hwcaps.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/arm64/elf_hwcaps.txt b/Documentation/arm64/elf_hwcaps.txt
index d6aff2c5e9e2..51ccfab408cc 100644
--- a/Documentation/arm64/elf_hwcaps.txt
+++ b/Documentation/arm64/elf_hwcaps.txt
@@ -78,11 +78,11 @@ HWCAP_EVTSTRM
 
 HWCAP_AES
 
-    Functionality implied by ID_AA64ISAR1_EL1.AES == 0b0001.
+    Functionality implied by ID_AA64ISAR0_EL1.AES == 0b0001.
 
 HWCAP_PMULL
 
-    Functionality implied by ID_AA64ISAR1_EL1.AES == 0b0010.
+    Functionality implied by ID_AA64ISAR0_EL1.AES == 0b0010.
 
 HWCAP_SHA1
 
@@ -153,7 +153,7 @@ HWCAP_ASIMDDP
 
 HWCAP_SHA512
 
-    Functionality implied by ID_AA64ISAR0_EL1.SHA2 == 0b0002.
+    Functionality implied by ID_AA64ISAR0_EL1.SHA2 == 0b0010.
 
 HWCAP_SVE
 
@@ -173,7 +173,7 @@ HWCAP_USCAT
 
 HWCAP_ILRCPC
 
-    Functionality implied by ID_AA64ISR1_EL1.LRCPC == 0b0002.
+    Functionality implied by ID_AA64ISAR1_EL1.LRCPC == 0b0010.
 
 HWCAP_FLAGM
 
-- 
2.1.4
