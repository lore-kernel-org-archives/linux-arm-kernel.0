From: superlibj8301@gmail.com (Richard Lee)
Date: Mon, 12 May 2014 10:19:53 +0800
Subject: [RFC][PATCH 0/2] Add IO mapping space reused support
Message-ID: <1399861195-21087-1-git-send-email-superlibj8301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Richard Lee (2):
  mm/vmalloc: Add IO mapping space reused interface.
  ARM: ioremap: Add IO mapping space reused support.

 arch/arm/mm/ioremap.c   | 11 ++++++++-
 include/linux/vmalloc.h |  5 ++++
 mm/vmalloc.c            | 63 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 1 deletion(-)

-- 
1.8.4
