From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon,  3 Nov 2014 18:41:58 +0100
Subject: [PATCH v3 0/4] Add support for pxa27x device-tree machine
Message-ID: <1415036522-7800-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Almost no change since v2, only the if (IS_ENABLED(CONFIG_OF)) test added to
patch 1/4 and an english typo to patch 3/4. I kept (a bit enthusiasticaly) your
Ack on patch 1 as you chose the way to amend the patch, and I'm okay with it
(and yes, my bot agrees too this time) and on patch 3 (typo).

If you don't agree with the Ack tell me. I'll leave the serie for 3 or 4 days
before considering the ack as granted.

Cheers.

--
Robert

Robert Jarzmik (4):
  arm: pxa: add device-tree irq init for pxa27x
  arm: pxa: move init functions into generic.h
  arm: pxa: remove unnecessary includes from pxa-dt
  arm: pxa: add pxa27x device-tree support

 arch/arm/mach-pxa/Kconfig               | 11 ++++++
 arch/arm/mach-pxa/Makefile              |  1 +
 arch/arm/mach-pxa/generic.h             | 65 +++++++++++++++++++++------------
 arch/arm/mach-pxa/include/mach/pxa25x.h |  8 ----
 arch/arm/mach-pxa/include/mach/pxa27x.h |  4 --
 arch/arm/mach-pxa/include/mach/pxa3xx.h |  5 ---
 arch/arm/mach-pxa/pxa-dt.c              | 18 +++++++--
 arch/arm/mach-pxa/pxa27x.c              |  6 +++
 8 files changed, 75 insertions(+), 43 deletions(-)

-- 
2.1.0
