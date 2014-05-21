From: ritesh.harjani@gmail.com (ritesh.harjani at gmail.com)
Date: Wed, 21 May 2014 09:43:19 +0530
Subject: [PATCH 0/1] Clean up the unused comments from arm64 tlbflush.h
Message-ID: <1400645600-35973-1-git-send-email-ritesh.harjani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ritesh Harjani <ritesh.harjani@gmail.com>

Based on suggestion[1] from Catalin, instead of defining
unused function defination for flush_kern_tlb_page, clean
up the function name from the comment in tlbflush.h.

[1]: http://www.spinics.net/lists/arm-kernel/msg332661.html

Ritesh Harjani (1):
  arm64: tlbflush.h: Clean up comment

 arch/arm64/include/asm/tlbflush.h | 6 ------
 1 file changed, 6 deletions(-)

-- 
1.8.1.3
