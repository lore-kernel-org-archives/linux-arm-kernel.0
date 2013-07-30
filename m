From: xvzhaobin@gmail.com (zhaobin xv)
Date: Tue, 30 Jul 2013 20:19:08 +0800
Subject: kernel makefile
Message-ID: <CANEcUBV0k_JgDyO6-MAzAqX3EwaL77ctwPRSzdkHD-qc-eJPEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

in arch/arm/boot/Makefile:
there is some makefile code:

ifeq ($(CONFIG_ZBOOT_ROM),y)
$(obj)/uImage: LOADADDR=$(CONFIG_ZBOOT_ROM_TEXT)
else
$(obj)/uImage: LOADADDR=$(ZRELADDR)
endif

$(obj)/uImage: STARTADDR=$(LOADADDR)

I can't understand the makefile syntax:$(obj)/uImage: STARTADDR=$(LOADADDR),
I can't find the syntax in GNU make Version 3.82
where can I find the syntax
