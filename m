From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 14 Mar 2013 12:38:00 +0800
Subject: [Suggestion] Latest randconfig build errors for Head.S
Message-ID: <51415428.1070401@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maintainers:

  are these warnings for head.S OK ?


make:
  make V=1 EXTRA_CFLAGS=-W ARCH=arm randconfig
    (this time, CONFIG_MMU=y)

warning information:
  arch/arm/boot/compressed/head.S: Assembler messages:
  arch/arm/boot/compressed/head.S:565: Warning: (null)
  arch/arm/boot/compressed/head.S:676: Warning: (null)
  arch/arm/boot/compressed/head.S:698: Warning: (null)
  arch/arm/boot/compressed/head.S:722: Warning: (null)
  arch/arm/boot/compressed/head.S:726: Warning: (null)
  arch/arm/boot/compressed/head.S:735: Warning: (null)
  arch/arm/boot/compressed/head.S:978: Warning: (null)
  arch/arm/boot/compressed/head.S:1017: Warning: (null)
  arch/arm/boot/compressed/head.S:1018: Warning: (null)
  arch/arm/boot/compressed/head.S:1048: Warning: (null)
  arch/arm/boot/compressed/head.S:1055: Warning: (null)
  arch/arm/boot/compressed/head.S:1063: Warning: (null)
  arch/arm/boot/compressed/head.S:1074: Warning: (null)
  arch/arm/boot/compressed/head.S:1088: Warning: (null)
  arch/arm/boot/compressed/head.S:1120: Warning: (null)
  arch/arm/boot/compressed/head.S:1122: Warning: (null)
  arch/arm/boot/compressed/head.S:1123: Warning: (null)
  arch/arm/boot/compressed/head.S:1130: Warning: (null)
  arch/arm/boot/compressed/head.S:1162: Warning: (null)



-- 
Chen Gang

Asianux Corporation
