From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 12 Mar 2012 20:05:38 +0000
Subject: [PATCH] ARM: davinci: cpufreq: fix compiler warning
In-Reply-To: <1331235404-15565-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1331235404-15565-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317F2E08@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Fri, Mar 09, 2012 at 01:06:44, Uwe Kleine-K?nig wrote:
> This fixes:
> 	arch/arm/mach-davinci/cpufreq.c: In function davinci_target:
> 	arch/arm/mach-davinci/cpufreq.c:98: warning: passing argument 2 of dev_printk from incompatible pointer type
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applying this, thanks!

Regards,
Sekhar
