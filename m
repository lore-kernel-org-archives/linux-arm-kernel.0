From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Tue, 02 Apr 2013 17:08:55 -0700 (PDT)
Subject: [PATCH 1/2] ARM: shmobile: R8A7779: add Ether support
In-Reply-To: <515AC546.90905@cogentembedded.com>
References: <201304020204.54546.sergei.shtylyov@cogentembedded.com>
 <87wqsl6ale.wl%kuninori.morimoto.gx@renesas.com>
 <515AC546.90905@cogentembedded.com>
Message-ID: <87txnocw6n.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sergei

> > Then, this (void *pdata) should be
> > (struct sh_eth_plat_data *pdata) IMO
> 
>     ether_device.dev.platform_data is 'void *'. I didn't want to bring in 
> extra header for the little use.

Not enough reason for me.

"void *" means there is no pointer check,
and extra header is just 1 line. No ?

If you want to use this style,
then, additional extra header is fate, IMO

Best regards
---
Kuninori Morimoto
