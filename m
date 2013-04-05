From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  5 Apr 2013 14:32:51 +0200
Subject: [PATCH 3.9-rc6] arm: mvebu: Fix the irq map function in SMP mode
Message-ID: <1365165172-11447-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

This patch is a fix for 3.9-rc6 to solve the issue reported by Ryan
Press: GPIO IRQ were no longer delivered to the CPUs. It has been
tested by Ezequiel. See the commit log for all the details.

This patch was applied on 3.9-rc5 and the commit "arm: mvebu: Use
local interrupt only for the timer 0".

Thanks

Gregory CLEMENT (1):
  arm: mvebu: Fix the irq map function in SMP mode

 arch/arm/mach-mvebu/irq-armada-370-xp.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

-- 
1.7.9.5
