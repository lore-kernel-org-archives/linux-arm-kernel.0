From: kevin.wells@nxp.com (Kevin Wells)
Date: Fri, 1 Apr 2011 23:19:23 +0200
Subject: [PATCH V2 1/3] arm: lpc32xx: add tsc-device
In-Reply-To: <1301592646-26356-1-git-send-email-w.sang@pengutronix.de>
References: <1301592646-26356-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F811ED78EE79@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Subject: [PATCH V2 1/3] arm: lpc32xx: add tsc-device
> 
> Fix the clock name, too.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

These 3 patches look good and work/build fine. Thanks again!
Tested-by: Kevin Wells <Kevin.wells@nxp.com>

> ---
>  arch/arm/mach-lpc32xx/clock.c  |    2 +-
>  arch/arm/mach-lpc32xx/common.c |   21 +++++++++++++++++++++
