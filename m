From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 12 Oct 2014 17:28:47 +0200
Subject: [PATCH v2 0/4] Add support for pxa27x device-tree machine
Message-ID: <1413127731-1187-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the second version of this patchset, to provide a device-tree machine
support for pxa27x.

Since latest review by Arnd :
 - patches 1, 3 and 4 were ok
 - patch 2 was respined

Cheers.

--
Robert

Robert Jarzmik (4):
  arm: pxa: add device-tree irq init for pxa27x
  arm: pxa: move init functions into generic.h
  arm: pxa: remove unecessary includes from pxa-dt
  arm: pxa: add pxa27x device-tree support

 arch/arm/mach-pxa/Kconfig               | 11 ++++++
 arch/arm/mach-pxa/Makefile              |  1 +
 arch/arm/mach-pxa/generic.h             | 65 +++++++++++++++++++++------------
 arch/arm/mach-pxa/include/mach/pxa25x.h |  8 ----
 arch/arm/mach-pxa/include/mach/pxa27x.h |  4 --
 arch/arm/mach-pxa/include/mach/pxa3xx.h |  5 ---
 arch/arm/mach-pxa/pxa-dt.c              | 18 +++++++--
 arch/arm/mach-pxa/pxa27x.c              |  5 +++
 8 files changed, 74 insertions(+), 43 deletions(-)

-- 
2.1.0
