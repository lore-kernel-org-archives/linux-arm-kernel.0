From: pasha.tatashin@oracle.com (Pavel Tatashin)
Date: Mon,  6 Nov 2017 13:35:14 -0500
Subject: [PATCH v2 0/2] don't use vmemmap_populate() to initialize shadow
Message-ID: <20171106183516.6644-1-pasha.tatashin@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Corrected "From" fields in these two patches to preserve the original
authorship.

Andrey Ryabinin (1):
  x86/mm/kasan: don't use vmemmap_populate() to initialize shadow

Will Deacon (1):
  arm64/mm/kasan: don't use vmemmap_populate() to initialize shadow

 arch/arm64/Kconfig          |   2 +-
 arch/arm64/mm/kasan_init.c  | 130 ++++++++++++++++++++++++----------------
 arch/x86/Kconfig            |   2 +-
 arch/x86/mm/kasan_init_64.c | 143 +++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 218 insertions(+), 59 deletions(-)

-- 
2.15.0
