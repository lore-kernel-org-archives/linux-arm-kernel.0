From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 15 Feb 2016 04:50:17 +0000
Subject: [PATCH] ARM: dts: porter: fix JP3 jumper description
In-Reply-To: <1655804.y4T36KvG5v@wasted.cogentembedded.com>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
 <1655804.y4T36KvG5v@wasted.cogentembedded.com>
Message-ID: <87fuwuinsh.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

> When finishing the Porter sound support patch, I managed to call the JP3
> jumper SW3 in the comment.  Fix this  along with (also miscalled) jumper
> positions...
> 
> Fixes: 493b4da7c10c ("ARM: dts: porter: add sound support")
> Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> 
> ---
> This patch is against the 'renesas-devel-20160209-v4.5-rc3' tag of Simon
> Horman's 'renesas.git' repo.
> 
> arch/arm/boot/dts/r8a7791-porter.dts |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: renesas/arch/arm/boot/dts/r8a7791-porter.dts
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7791-porter.dts
> +++ renesas/arch/arm/boot/dts/r8a7791-porter.dts
> @@ -11,8 +11,8 @@
>  /*
>   * SSI-AK4642
>   *
> - * SW3: 1: AK4642
> - *      3: ADV7511
> + * JP3: 2-1: AK4642
> + *      2-3: ADV7511
>   *
>   * This command is required before playback/capture:
>   *
> 
