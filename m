From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 25 Aug 2013 21:43:32 +0400
Subject: [PATCH v2 0/2] R8A7779/Marzen: HPB-DMAC support for SDHI0
Message-ID: <201308252143.33458.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against the Simon Horman's 'renesas.git' repo,
'renesas-devel-20130823' tag. Here we add the HPB-DMAC platform code working on
R8A7779 and enable DMA for SDHI0 on Marzen. The patchset depends on the R-Car
HPB-DMAC driver patch posted earlier.

[1/2] ARM: shmobile: r8a7779: add HPB-DMAC support
[2/2] ARM: shmobile: Marzen: enable DMA for SDHI0

WBR, Sergei
