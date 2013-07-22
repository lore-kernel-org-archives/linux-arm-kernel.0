From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 23 Jul 2013 02:18:00 +0400
Subject: [PATCH v2 0/2] R8A7778/BOCK-W: HPB-DMAC support for SDHI0
Message-ID: <201307230218.01495.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 3 patches against the Simon Horman's 'renesas.git' repo,
'renesas-next-20130722' tag. Here we add the HPB-DMAC platform code working on
the R8A7778 and enable DMA for SDHI0 on BOCK-W. The patchset depends on the
R-Car HPB-DMAC driver patch posted earlier.

[1/2] ARM: shmobile: r8a7778: add HPB-DMAC support
[2/2] ARM: shmobile: BOCK-W: enable DMA for SDHI0

   The former patch #1 has been merged to the next patch moving the data from
the now removed <mach/dma.h> to <mach/r8a7778.h>.

WBR, Sergei
