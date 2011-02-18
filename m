From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Feb 2011 22:11:49 +0000
Subject: [PATCH] arm/mach-stmp3xxx: remove headers for DUART
In-Reply-To: <1298062481-29547-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1298062481-29547-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110218221149.GC19427@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 09:54:41PM +0100, Uwe Kleine-K?nig wrote:
> From: Wolfram Sang <w.sang@pengutronix.de>
> 
> The DUART is an AMBA PL011 and its registers are already available in
> linux/amba/serial.h
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> there is no maintainer listed in MAINTAINERS.  Should I put is in the
> patch system?  Or should it go via Sascha, as stmp3xxx is the
> predecessor of i.MX23?

stmp came from embedded alley.  See git logs.  That probably gives
you an idea where to send the patch.
