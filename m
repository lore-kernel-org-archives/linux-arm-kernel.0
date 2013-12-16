From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Mon, 16 Dec 2013 15:54:47 -0800 (PST)
Subject: [PATCH] ARM: shmobile: r8a7790 - fix shdi resource sizes
In-Reply-To: <1387197528-1177-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1387197528-1177-1-git-send-email-ben.dooks@codethink.co.uk>
 <1387197528-1177-2-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <87sitsnygu.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

> The r8a7790.dtsi file has four sdhi nodes which the first two have the wrong
> resource size for their register block. This causes the sh_modbile_sdhi driver
> to fail to communicate with card at-all.
> 
> Change sdhi{0,1} node size from 0x100 to 0x200 to correct these nodes
> as per Kuninori Morimoto's response to the original patch where all four
> nodes where changed. sdhi{2,3} are the correct size.
> 
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Linux SH <linux-sh@vger.kernel.org>
> Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Tested-by: William Towle <william.towle@codethink.co.uk>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


Best regards
---
Kuninori Morimoto
