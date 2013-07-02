From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Tue, 2 Jul 2013 05:41:37 +0000
Subject: [PATCH 2/4] davinci: da8xx/omap-l1: Remove hard coding of rtc
 device wakeup
In-Reply-To: <51D267BE.8090605@ti.com>
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
 <1372412109-986-3-git-send-email-gururaja.hebbar@ti.com>
 <51D267BE.8090605@ti.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EC4E74E@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 02, 2013 at 11:10:14, Nori, Sekhar wrote:
> 
> On 6/28/2013 3:05 PM, Hebbar Gururaja wrote:
> > Since now rtc-omap driver itself calls deice_init_wakeup(dev, true),
> > duplicate call from the rtc device registration can be removed.
> > 
> > This is basically a partial revert of the prev commit
> > 
> > commit 75c99bb0006ee065b4e2995078d779418b0fab54
> > Author: Sekhar Nori <nsekhar@ti.com>
> > 
> >     davinci: da8xx/omap-l1: mark RTC as a wakeup source
> > 
> > Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> > Cc: Sekhar Nori <nsekhar@ti.com>
> > Cc: Kevin Hilman <khilman@linaro.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> 
> Subject line should be prefixed with ARM: keeping with arch/arm
> convention. Otherwise looks good.

Will fix it in v2.

> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks for the review.

> 
> Thanks,
> Sekhar
> 


Regards, 
Gururaja
