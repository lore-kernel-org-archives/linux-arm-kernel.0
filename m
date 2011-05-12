From: mike@compulab.co.il (Mike Rapoport)
Date: Fri, 13 May 2011 00:40:52 +0300
Subject: [RESEND PATCH 0/4] omap: merge IGEP v2 and v3
Message-ID: <cover.1305235542.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

I'm resending this with the correct arm-linux mailing list cc'ed..
Just discard the first set, sorry for the noise...

This is yet another attempt to reduce code duplication in the board files :)
Only build tested, since I don't have the hardware, so I belive an Ack from
Enric is required.

Mike Rapoport (4):
  omap: igep0020: name refactoring for future merge with IGEP3
  omap: igep0020: minor refactoring
  omap: igep0020: add support for IGEP3
  omap: drop board-igep0030.c

 arch/arm/mach-omap2/Kconfig          |    1 +
 arch/arm/mach-omap2/Makefile         |    2 -
 arch/arm/mach-omap2/board-igep0020.c |  286 +++++++++++++---------
 arch/arm/mach-omap2/board-igep0030.c |  438 ----------------------------------
 4 files changed, 174 insertions(+), 553 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-igep0030.c

-- 
1.7.3.1
