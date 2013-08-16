From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 16 Aug 2013 17:32:13 +0530
Subject: [Patch V2 2/4] ARM: Davinci: da8xx/omap-l1: Remove hard coding
 of rtc device wakeup
In-Reply-To: <1372841225-18813-3-git-send-email-gururaja.hebbar@ti.com>
References: <1372841225-18813-1-git-send-email-gururaja.hebbar@ti.com>
 <1372841225-18813-3-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <520E14C5.9090308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 July 2013 02:17 PM, Hebbar Gururaja wrote:
> Since now rtc-omap driver itself calls deice_init_wakeup(dev, true),
> duplicate call from the rtc device registration can be removed.
> 
> This is basically a partial revert of the prev commit
> 
> commit 75c99bb0006ee065b4e2995078d779418b0fab54
> Author: Sekhar Nori <nsekhar@ti.com>
> 
>     davinci: da8xx/omap-l1: mark RTC as a wakeup source
> 
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> Acked-by: Kevin Hilman <khilman@linaro.org>
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> Cc: Russell King <linux@arm.linux.org.uk>

Queuing for v3.12. In subject line, please use lower case except for
acronyms and for "ARM". Also, we dont use omap-l1 to avoid confusion
with the real omaps. Just da8xx is enough. I have fixed these locally
this time.

Thanks,
Sekhar
