From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Sep 2018 10:15:49 -0700
Subject: [PATCH] ARM: omap2+: hwmod_core: improve the support for clkctrl
 clocks
In-Reply-To: <1535727683-23930-1-git-send-email-t-kristo@ti.com>
References: <1535727683-23930-1-git-send-email-t-kristo@ti.com>
Message-ID: <20180907171549.GM5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Tero Kristo <t-kristo@ti.com> [180831 08:05]:
> This patch adds support for split memory ranges for clkctrl providers.
> This is necessary to support the coming clockdomain based split of
> clkctrl provider ranges, instead of the current CM instance based one.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> Note: This patch can be applied independently, the only hard dependency
> with the clkctrl data split is with the DT changes, those must follow
> everything else.

Tero, looks like this won't apply against v4.19-rc1, can you
please repost?

Regards,

Tony
