From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 19 Aug 2014 12:41:41 -0700
Subject: [PATCHv4 0/2] arm64 CONFIG_DEBUG_SET_MODULE_RONX support
Message-ID: <1408477303-2640-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is another version of DEBUG_SET_MODULE_RONX support for arm64.

Thanks,
Laura

v4: Switch to one function to do set/clear per suggestion of Will

v3: Addressed comments by Will/Steve


Laura Abbott (2):
  arm64: Introduce {set,clear}_pte_bit
  arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support

 arch/arm64/Kconfig.debug            | 11 +++++
 arch/arm64/include/asm/cacheflush.h |  4 ++
 arch/arm64/include/asm/pgtable.h    | 33 +++++++------
 arch/arm64/mm/Makefile              |  2 +-
 arch/arm64/mm/pageattr.c            | 96 +++++++++++++++++++++++++++++++++++++
 5 files changed, 131 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm64/mm/pageattr.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
