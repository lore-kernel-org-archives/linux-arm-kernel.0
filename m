From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri,  4 Nov 2016 20:43:33 +0900
Subject: [PATCH 0/3] ARM: cache-uniphier: slight cleanups and trivial coding
 style fix
Message-ID: <1478259816-24965-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cache-uniphier is a full-custom outer-cache for
Socionext UniPhier SoC family.

This series includes SoC-specific cleanups and
a trivial coding style fix suggested by Documentation/CodingStyle.



Masahiro Yamada (3):
  ARM: cache-uniphier: call kzalloc() after DT property parsing
  ARM: cache-uniphier: refactor jump label to follow coding style
    guideline
  ARM: cache-uniphier: clean up active way setup code

 arch/arm/mm/cache-uniphier.c | 64 ++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 35 deletions(-)

-- 
1.9.1
