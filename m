From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 24 Aug 2013 02:44:38 +0400
Subject: [PATCH v3 0/2] R8A7778/BOCK-W: HPB-DMAC support for SDHI0
Message-ID: <201308240244.38963.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against the Simon Horman's 'renesas.git' repo,
'renesas-next-20130823' tag. Here we add the HPB-DMAC platform code working on
the R8A7778 and enable DMA for SDHI0 on BOCK-W (Max has fixed the wrong settings
that led to the SDHI0 DMA working incorrectly). The patchset depends on the
R-Car HPB-DMAC driver patch posted earlier.

[1/2] ARM: shmobile: r8a7778: add HPB-DMAC support
[2/2] ARM: shmobile: BOCK-W: enable DMA for SDHI0

   The former patch #1 has been merged to the next patch moving the data from
the now removed <mach/dma.h> to <mach/r8a7778.h>.

WBR, Sergei
