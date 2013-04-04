From: horms@verge.net.au (Simon Horman)
Date: Thu, 4 Apr 2013 15:52:23 +0900
Subject: [PATCH 0/5 v3] ARM: shmobile: Add SMSC support on Bock-W
In-Reply-To: <CANqRtoSEf7TuBN6DZ7Qn9S8h8ts_pxahpELEK2b4KgAVpN7svw@mail.gmail.com>
References: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
 <87fvzb56n3.wl%kuninori.morimoto.gx@renesas.com>
 <87sj395zvv.wl%kuninori.morimoto.gx@renesas.com>
 <CANqRtoSEf7TuBN6DZ7Qn9S8h8ts_pxahpELEK2b4KgAVpN7svw@mail.gmail.com>
Message-ID: <20130404065222.GR28297@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 05:19:10PM +0900, Magnus Damm wrote:
> Hi Morimoto-san, Simon,
> 
> On Tue, Apr 2, 2013 at 1:18 PM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> >
> > Hi Simon
> >
> > These patches are v3 of extpin support on r8a7778,
> > and enable SMSC ether support on Bock-W board
> >
> > This patch set is based latest simon/next
> >
> > Kuninori Morimoto (5):
> >       ARM: shmobile: r8a7778: remove pointless PLATFORM_INFO()
> >       ARM: shmobile: r8a7778: add r8a7778_init_irq_extpin()

	  Queued up in the soc-r8a7778 branch.

> >       ARM: shmobile: bockw: add SMSC ethernet support
> >       ARM: shmobile: bockw: enable network settings on bootargs

	  Queued up in the boards-bockw branch.

> >       ARM: shmobile: bockw: enable SMSC ethernet on defconfig

	  Queued up in the defconfig-bockw branch.

> Thanks, these are all fine with me.
> 
> Acked-by: Magnus Damm <damm@opensource.se>

I will endeavour to get this included in v3.10.
