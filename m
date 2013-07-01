From: horms@verge.net.au (Simon Horman)
Date: Mon, 1 Jul 2013 10:30:36 +0900
Subject: [PATCH 0/3] R8A7778/BOCK-W: HPB-DMAC support for SDHI0
In-Reply-To: <201306300243.57180.sergei.shtylyov@cogentembedded.com>
References: <201306300243.57180.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130701013036.GC14567@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 30, 2013 at 02:43:56AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 3 patches against the Simon Horman's 'renesas.git' repo,
> 'renesas-next-20130628' tag. Here we add the HPB-DMAC platform code working on
> the R8A7778 and enable DMA for SDHI0 on BOCK-W. The patchset depends on the
> R-Car HPB-DMAC driver patch posted earlier.
> 
> [1/3] ARM: shmobile: use common platform header for HPB-DMAC
> [2/3] ARM: shmobile: r8a7778: add HPB-DMAC support
> [3/3] ARM: shmobile: BOCK-W: enable DMA for SDHI0

Hi Magnus, Hi Morimoto-san,

could you please review is series?
