From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 17 May 2013 14:25:02 +0200
Subject: [PATCH] [for 3.10-rc] ARM: mvebu: select ARCH_REQUIRE_GPIOLIB for
 mvebu platform
Message-ID: <1368793503-8883-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The following fix a regression which appear in 3.10-rc1: the GPIOLIB
is nor more selected for mvebu. I found this while I was trying to
test the GPIO buttons on the OpenBlocks AX3, but it impacts all the
mvebu platform.

It was the conjunction of a lot of
elements which lead to this bug, see the commit log for the
details. The patch by itself is very simple.

Regards,

Gregory CLEMENT (1):
  ARM: mvebu: select ARCH_REQUIRE_GPIOLIB for mvebu platform

 arch/arm/mach-mvebu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
1.8.1.2
