From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 22 Feb 2016 16:31:11 +0900
Subject: [PATCH 0/6] ARM: decompressor: several cleanups
Message-ID: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




Masahiro Yamada (6):
  ARM: decompressor: drop unneeded assignments to "targets"
  ARM: decompressor: drop more unneeded assignments to "targets"
  ARM: decompressor: use clean-files instead of extra-y to clean files
  ARM: decompressor: drop redundant FORCE in Makefile
  ARM: decompressor: merge piggy.*.S and simplify Makefile
  ARM: decompressor: rename suffix_y to compress-y

 arch/arm/boot/compressed/.gitignore                |  6 +----
 arch/arm/boot/compressed/Makefile                  | 31 ++++++++++------------
 arch/arm/boot/compressed/{piggy.gzip.S => piggy.S} |  2 +-
 arch/arm/boot/compressed/piggy.lz4.S               |  6 -----
 arch/arm/boot/compressed/piggy.lzma.S              |  6 -----
 arch/arm/boot/compressed/piggy.lzo.S               |  6 -----
 arch/arm/boot/compressed/piggy.xzkern.S            |  6 -----
 7 files changed, 16 insertions(+), 47 deletions(-)
 rename arch/arm/boot/compressed/{piggy.gzip.S => piggy.S} (67%)
 delete mode 100644 arch/arm/boot/compressed/piggy.lz4.S
 delete mode 100644 arch/arm/boot/compressed/piggy.lzma.S
 delete mode 100644 arch/arm/boot/compressed/piggy.lzo.S
 delete mode 100644 arch/arm/boot/compressed/piggy.xzkern.S

-- 
1.9.1
