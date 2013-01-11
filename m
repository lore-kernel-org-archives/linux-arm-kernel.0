From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 Jan 2013 12:02:35 +0800
Subject: [PATCH 0/3] arch_decomp_wdog cleanup
In-Reply-To: <alpine.LFD.2.02.1301102220230.6300@xanadu.home>
References: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
 <alpine.LFD.2.02.1301101430200.6300@xanadu.home>
 <20130111025311.GD9139@S2101-09.ap.freescale.net>
 <alpine.LFD.2.02.1301102220230.6300@xanadu.home>
Message-ID: <20130111040233.GD8680@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 10:25:29PM -0500, Nicolas Pitre wrote:
> "not unused" that means "used".  Probably you meant "not used" or "now 
> unused".
> 
> Also, "all the arch_decomp_wdog() related codes are ..." doesn't look 
> like proper english.  I'd say "all the arch_decomp_wdog() related 
> functions are .." or "all the arch_decomp_wdog() related code is ..".
> 
English became the hard part of my life when I was a high school
student :)

    Besides the fact that CONFIG_S3C_BOOT_WATCHDOG is defined nowhere, with
    ARCH_HAS_DECOMP_WDOG removed from arch/arm/boot/compressed/decompress.c,
    all the arch_decomp_wdog() related code is not used.  Remove them.

Shawn
