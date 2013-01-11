From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 10 Jan 2013 22:25:29 -0500 (EST)
Subject: [PATCH 0/3] arch_decomp_wdog cleanup
In-Reply-To: <20130111025311.GD9139@S2101-09.ap.freescale.net>
References: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
 <alpine.LFD.2.02.1301101430200.6300@xanadu.home>
 <20130111025311.GD9139@S2101-09.ap.freescale.net>
Message-ID: <alpine.LFD.2.02.1301102220230.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Jan 2013, Shawn Guo wrote:

> On Thu, Jan 10, 2013 at 02:32:30PM -0500, Nicolas Pitre wrote:
> > On Thu, 10 Jan 2013, Shawn Guo wrote:
> > 
> > > All the arch_decomp_wdog related codes are there without any users,
> > > since ARCH_HAS_DECOMP_WDOG is only used by lib/inflate.c which however
> > > is not used by arch/arm/boot/compressed/decompress.c.
> > 
> > It is also worth mentioning that CONFIG_S3C_BOOT_WATCHDOG is not set 
> > anywhere.
> > 
> Yeah, the commit log of patch #3 now looks like:
> 
>     Besides the fact that CONFIG_S3C_BOOT_WATCHDOG is defined nowhere, with
>     ARCH_HAS_DECOMP_WDOG removed from arch/arm/boot/compressed/decompress.c,
>     all the arch_decomp_wdog() related codes are not unused.  Remove them.

"not unused" that means "used".  Probably you meant "not used" or "now 
unused".

Also, "all the arch_decomp_wdog() related codes are ..." doesn't look 
like proper english.  I'd say "all the arch_decomp_wdog() related 
functions are .." or "all the arch_decomp_wdog() related code is ..".


Nicolas
