From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  4 Mar 2015 20:11:24 +0100
Subject: [PATCH v3 0/4] arm64: head.S cleanup
Message-ID: <1425496288-14483-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This some janitorial work on head.S, just stuff I noticed when making
changes to it for other reasons.

Changes since v2:
- added separate patch to add macros for adrp/add, adrp/ldr and adrp/str
- added R-b's

Ard Biesheuvel (4):
  arm64: add macros for common adrp usages
  arm64: remove processor_id
  arm64: remove __switch_data object from head.S
  arm64: remove __lookup_processor_type_data, object from head.S

 arch/arm64/include/asm/assembler.h | 20 +++++++++++++++
 arch/arm64/kernel/head.S           | 52 ++++++++------------------------------
 arch/arm64/kernel/setup.c          |  3 ---
 3 files changed, 31 insertions(+), 44 deletions(-)

-- 
1.8.3.2
