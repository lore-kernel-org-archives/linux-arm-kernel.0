From: andreyknvl@google.com (Andrey Konovalov)
Date: Thu, 11 Jan 2018 16:29:07 +0100
Subject: [PATCH 0/2] kasan: a few cleanups
Message-ID: <cover.1515684162.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up usage of KASAN_SHADOW_SCALE_SHIFT and fix prototype author email
address.

Andrey Konovalov (2):
  kasan: fix prototype author email address
  kasan: clean up KASAN_SHADOW_SCALE_SHIFT usage

 arch/arm64/include/asm/kasan.h  | 3 ++-
 arch/arm64/include/asm/memory.h | 3 ++-
 arch/arm64/mm/kasan_init.c      | 3 ++-
 arch/x86/include/asm/kasan.h    | 8 ++++++--
 include/linux/kasan.h           | 2 --
 mm/kasan/kasan.c                | 2 +-
 mm/kasan/report.c               | 2 +-
 7 files changed, 14 insertions(+), 9 deletions(-)

-- 
2.16.0.rc1.238.g530d649a79-goog
