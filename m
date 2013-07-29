From: xvzhaobin@gmail.com (zhaobin xv)
Date: Mon, 29 Jul 2013 21:12:58 +0800
Subject: ZTEXTADDR
Message-ID: <CANEcUBWQgoEQ2nrzV4F-dbPzQQYW1NqFwGxwGMOBzo3g-aAuug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi
   I see some blogs aboot ZTEXTADDR
in linux 2.4.18 :
in kernel/arch/arm/boot/Makefile?
 ifeq ($(CONFIG_ARCH_S3C2410),y)
ZTEXTADDR = 0x30008000
ZRELADDR = 0x30008000
endif
but
in linux 2.6. :
in kernel/arch/arm/boot/Makefile:
ZTEXTADDR = 0


I want to know why to change?
ZTEXTADDR is link addr or phs addr?
