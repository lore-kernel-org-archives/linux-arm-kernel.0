From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  9 Nov 2015 09:55:44 +0100
Subject: [PATCH 0/2] arm64 STRICT_MM_TYPECHECKS fixes
Message-ID: <1447059346-12050-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a couple of things I spotted when building with STRICT_MM_TYPECHECKS
enabled, one of which is in new code (current merge window) and the other
is in code that I introduced myself in the FDT fixmap remapping code.

Ard Biesheuvel (2):
  arm64: fix STRICT_MM_TYPECHECKS issue in PTE_CONT manipulation
  arm64: fix R/O permissions of FDT mapping

 arch/arm64/include/asm/pgtable.h | 1 +
 arch/arm64/mm/mmu.c              | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
1.9.1
