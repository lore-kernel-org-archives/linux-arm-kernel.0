From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 14 Dec 2015 01:00:59 +0000
Subject: [PATCH/RFC 05/19] ARM: shmobile: r8a7793: add MSTP10 clocks to
 device tree
In-Reply-To: <1449802376-11301-6-git-send-email-horms+renesas@verge.net.au>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
 <1449802376-11301-6-git-send-email-horms+renesas@verge.net.au>
Message-ID: <87oadtkfrw.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> Instantiate MSTP10 clocks in r8a7793 device tree.
> 
> Based on similar work for the r8a7791 by Kuninori Morimoto.
> 
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
(snip)
> +		mstp10_clks: mstp10_clks at e6150998 {
> +			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
> +			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;

I wonder does r8a7793 use mstp driver ? not mssr ?
Because RFC ?

Best regards
---
Kuninori Morimoto
