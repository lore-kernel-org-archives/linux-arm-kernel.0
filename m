From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 07 Dec 2010 13:04:56 -0800
Subject: [PATCH] arm: plat-omap: counter_32k: Fix build error due to IS_ERR
In-Reply-To: <1291723777-27316-1-git-send-email-sourav.poddar@ti.com> (Sourav
	Poddar's message of "Tue, 7 Dec 2010 17:39:37 +0530")
References: <1291723777-27316-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <87fwu9l2fb.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sourav Poddar <sourav.poddar@ti.com> writes:

> Fix the following build error by including linux/err.h
> arch/arm/plat-omap/counter_32k.c: In function 'omap_init_clocksource_32k':
> arch/arm/plat-omap/counter_32k.c:167: error: implicit declaration of
>                                       function 'IS_ERR'
>
> The above error is due to the following commit:
> subject: arm: plat-omap: counter_32k: use IS_ERR() instead of NULL check
> commit: 235fbace0334c846c21e902f330020122fc85955
>
> Created on linux-omap-2.6 branch: omap-fixes
>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> Reviewed-by: Charulatha V <charu@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Just noticed this one too.

Kevin
