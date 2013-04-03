From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 3 Apr 2013 17:19:10 +0900
Subject: [PATCH 0/5 v3] ARM: shmobile: Add SMSC support on Bock-W
In-Reply-To: <87sj395zvv.wl%kuninori.morimoto.gx@renesas.com>
References: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
 <87fvzb56n3.wl%kuninori.morimoto.gx@renesas.com>
 <87sj395zvv.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <CANqRtoSEf7TuBN6DZ7Qn9S8h8ts_pxahpELEK2b4KgAVpN7svw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Morimoto-san, Simon,

On Tue, Apr 2, 2013 at 1:18 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Simon
>
> These patches are v3 of extpin support on r8a7778,
> and enable SMSC ether support on Bock-W board
>
> This patch set is based latest simon/next
>
> Kuninori Morimoto (5):
>       ARM: shmobile: r8a7778: remove pointless PLATFORM_INFO()
>       ARM: shmobile: r8a7778: add r8a7778_init_irq_extpin()
>       ARM: shmobile: bockw: add SMSC ethernet support
>       ARM: shmobile: bockw: enable network settings on bootargs
>       ARM: shmobile: bockw: enable SMSC ethernet on defconfig

Thanks, these are all fine with me.

Acked-by: Magnus Damm <damm@opensource.se>
