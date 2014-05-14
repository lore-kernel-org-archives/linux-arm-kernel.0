From: superlibj8301@gmail.com (Richard Lee)
Date: Wed, 14 May 2014 16:18:50 +0800
Subject: [PATCHv2 0/2] Add IO mapping space reused support
Message-ID: <1400055532-13134-1-git-send-email-superlibj8301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in V2:
 - Uses the atomic_t instead.
 - Revises some comment message.


Richard Lee (2):
  mm/vmalloc: Add IO mapping space reused interface support.
  ARM: ioremap: Add IO mapping space reused support.

 arch/arm/mm/ioremap.c   |  6 ++++
 include/linux/vmalloc.h |  5 +++
 mm/vmalloc.c            | 82 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

-- 
1.8.4
