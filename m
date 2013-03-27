From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 14:34:56 +0900
Subject: [PATCH 0/3] ARM: shmobile: Add SMSC support on Bock-W
In-Reply-To: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
References: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20130327053454.GP25431@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 12:13:31AM -0700, Kuninori Morimoto wrote:
> 
> Hi Arnd, Simon, Magnus
> 
> These patch set add extpin support on r8a7778,
> and enable SMSC ether on Bock-W board
> 
> This patch set is based on simon/next + my previous Bock-W patch set

Which Magnus has Acked and I will queue up for v3.10.

> Kuninori Morimoto (3):
>       ARM: shmobile: define PLATFORM_xxx_INFO()
>       ARM: shmobile: r8a7778: add r8a7778_init_irq_extpin()
>       ARM: shmobile: bockw: add SMSC ethernet support

Magnus, I think these are the only outstanding Bock-W patches
that are awaiting your review.

I have looked over them and don't have any objections at this stage.
