From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Jan 2012 15:35:11 +0800
Subject: [PATCH 1/3] mc13xxx-core: Prepare for separate spi and i2c
 backends.
In-Reply-To: <1326934894-29516-2-git-send-email-marc@cpdesign.com.au>
References: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
 <1326934894-29516-2-git-send-email-marc@cpdesign.com.au>
Message-ID: <20120119073509.GE2247@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forgot to mention in my last reply that I recently added device tree
probe support for mc13xxx-core which has hit the mainline, so you may
need to rebase this series, or you will be asked by Samuel to anyway,
I guess :)

One nit on the subject of this patch: you may want to have prefix
"mfd: mc13xxx-core: ..." to align with the other two patches in the
series.

-- 
Regards,
Shawn

On Thu, Jan 19, 2012 at 12:01:32PM +1100, Marc Reilly wrote:
> This patch abstracts the bus specific operations from the driver core.
> Read and write handlers are introduced and generic initialization is
> consolidated into mc13xxx_comon_init. The irq member is removed because
> it is unused.
> 
> Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
