From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Wed, 22 Mar 2017 20:04:26 +0300
Subject: [PATCH] ARM: dts: rockchip: increase SD clock frequency on Radxa
 Rock
In-Reply-To: <1978752.xjtBqdMt97@phil>
References: <1490110822-3310-1-git-send-email-al.kochet@gmail.com>
 <1978752.xjtBqdMt97@phil>
Message-ID: <FCE5C7E0-7BED-4600-952A-E1EBC900F814@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 22 ????? 2017 ?., ? 19:47, Heiko Stuebner <heiko@sntech.de> ???????(?):
> 
> sorry, but I will not apply this patch at this time.

> When testing on my radxarock with the card I always use upon entering the 
> rootfs everything explodes with -110 errors, while without that patch the card 
> runs stable as far as I can tell.

> I also don't have the time to investigate further right now though.

Ok. Let leave as is for now.

My radxa worked stable for a year with this settings.
And my custom rk3188 based board also has this setting. Kernel 4.8.
And I saw -110 errors only then I disconnect SD-card from board.
