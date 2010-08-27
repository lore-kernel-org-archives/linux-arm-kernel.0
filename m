From: cjb@laptop.org (Chris Ball)
Date: Fri, 27 Aug 2010 20:39:10 +0100
Subject: [PATCH v8 0/2] sDMA descriptor autoloading feature
In-Reply-To: <i2x618f0c911004291034g7f5b377ds5efaf74c901bc036@mail.gmail.com>
References: <i2x618f0c911004291034g7f5b377ds5efaf74c901bc036@mail.gmail.com>
Message-ID: <20100827193910.GG23079@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Venkatraman,

On Thu, Apr 29, 2010 at 11:04:34PM +0530, Venkatraman S wrote:
>     This patch series is the introduction of new sDMA feature: descriptor
> autoloading (v8) and it's adoption by the OMAP HSMMC driver.
> 
>    The previous version (v7) was blocked on achieving proper interrupt
> syncronisation
> between the MMC and DMA callback in the HSMMC driver.
>   Thanks to Adrian Hunter's patch, https://patchwork.kernel.org/patch/94670/
> this has been cleaned up.
> 
> Current version is based on for-next branch + Adrian Hunter's
> interrupt syncronisation patch
> (https://patchwork.kernel.org/patch/94670)
> 
> Changes since v7:
>   * Removed the 'fix race condition between DMA and HSMMC callback'
> part of the series
>   * Added memory barries in start and resume sglist transfer for cpu
> buffer syncronization
>   * Cleanup and comments
> 
> This has been tested on OMAP3430, OMAP3630 and OMAP4430 SDP
> for MMC file transfer and as boot file system.

The comments on this patchset were positive apart from some stylistic
changes -- would you like to resubmit a new patch?

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
