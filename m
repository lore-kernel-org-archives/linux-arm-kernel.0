From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 1 Dec 2010 14:16:00 +0200
Subject: [PATCH v5] ARM: s3c244x: Fix mess with gpio {set,
	get}_pull callbacks
In-Reply-To: <003c01cb914f$fc6d3350$f54799f0$%kim@samsung.com>
References: <4CF55785.5090403@metafoo.de>
	<201012011217.41602.anarsoul@gmail.com>
	<003c01cb914f$fc6d3350$f54799f0$%kim@samsung.com>
Message-ID: <201012011416.01065.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 December 2010 14:05:00 Kukjin Kim wrote:
> Yeah, right...it depends on each SoCs. But, if there is no setup it in
> map_io(), there is no functions of set_pull() and get_pull(). As you know,
> used s3c_gpio_{set,get}pull_1up as default before your patch...
> 
> Hmm...however, I will think about its necessity again.

In this case it will fail if SoC does not support pull up, so does it matter 
how it will fail?
 
> Ok..I will do it and will apply.
> Then, will be sent to Linus during 37-rc.

Thanks

Regards
Vasily
