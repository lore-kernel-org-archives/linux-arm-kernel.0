From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 1 Mar 2012 11:07:05 +0530
Subject: [GIT PULL] merge PL330 DMAC driver
In-Reply-To: <077301ccf769$f6ac3750$e404a5f0$%kim@samsung.com>
References: <077301ccf769$f6ac3750$e404a5f0$%kim@samsung.com>
Message-ID: <CABb+yY2hxuxMKsN0gHKwwoVtnHJ+z-gANtsMXA+tKsmk+MRzew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 1, 2012 at 10:42 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>
> Boojin Kim (3):
> ? ? ?DMA: PL330: Merge PL330 driver into drivers/dma/
>
You didn't check if upstream has moved since you first prepared your
patchset.
This patch doesn't account for
    ARM: 7326/2: PL330: fix null pointer dereference in pl330_chan_ctrl()
    ARM: 7164/3: PL330: Fix the size of the dst_cache_ctrl field

Btw, adding new copyright notice every year, rather than updating the existing
one isn't very cool. Other than that it looks ok finally.


> ? ? ?DMA: PL330: Removes useless function
> ? ? ?DMA: PL330: Support MEMTOMEM transmit w/o RMB, WMB
Look OK.
      Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
