From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 30 Jun 2013 02:43:56 +0400
Subject: [PATCH 0/3] R8A7778/BOCK-W: HPB-DMAC support for SDHI0
Message-ID: <201306300243.57180.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 3 patches against the Simon Horman's 'renesas.git' repo,
'renesas-next-20130628' tag. Here we add the HPB-DMAC platform code working on
the R8A7778 and enable DMA for SDHI0 on BOCK-W. The patchset depends on the
R-Car HPB-DMAC driver patch posted earlier.

[1/3] ARM: shmobile: use common platform header for HPB-DMAC
[2/3] ARM: shmobile: r8a7778: add HPB-DMAC support
[3/3] ARM: shmobile: BOCK-W: enable DMA for SDHI0

WBR, Sergei
