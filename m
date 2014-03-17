From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Sun, 16 Mar 2014 19:26:07 -0700 (PDT)
Subject: [PATCH] ARM: shmobile: lager-reference: Work around core clock
 issues
In-Reply-To: <1395022736-2921-1-git-send-email-horms+renesas@verge.net.au>
References: <1395022736-2921-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <87mwgpv9vo.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

very tiny comment

> Due to issues with runtime PM clock management, clocks not explicitly
> managed by their drivers may not be enabled at all, or be inadvertently
> disabled by the clk_disable_unused() late initcall.
> 
> Until this is fixed, add a temporary workaround, calling
> shmobile_clk_workaround() with enable == true.
> 
> For now this enables the clocks for: ether, msiof1, qspi_mod, and
> thermal. More clocks can be added if needed.
> 
> Based on work for the koelsch board by eert Uytterhoeven.

I guess

- Based on work for the koelsch board by eert Uytterhoeven.
+ Based on work for the koelsch board by Geert Uytterhoeven.
