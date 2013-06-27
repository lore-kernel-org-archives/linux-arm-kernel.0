From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 26 Jun 2013 22:41:43 -0700 (PDT)
Subject: [PATCH v3 0/2] ARM: shmobile: r8a7790: add thermal driver support
In-Reply-To: <1372297984-9315-1-git-send-email-horms+renesas@verge.net.au>
References: <1372297984-9315-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <871u7o2jqk.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> This short series enables the thermal driver on the r8a7790 SoC
> and thus the lager board.
> 
> It is based on renesas-next-20130620
> 
> v3
> * Correct title of clocks patch to refer to r8a7790
> 
> v2
> * Add clocks patch
> 
> Simon Horman (2):
>   ARM: shmobile: r8a7790: add clocks for thermal
>   ARM: shmobile: r8a7790: add thermal driver support
> 
>  arch/arm/mach-shmobile/clock-r8a7790.c |  4 ++++
>  arch/arm/mach-shmobile/setup-r8a7790.c | 12 ++++++++++++
>  2 files changed, 16 insertions(+)

For all patches

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>



Best regards
---
Kuninori Morimoto
