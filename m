From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 1 Nov 2009 21:32:40 +0100
Subject: [PATCH] at91: support for eco920
In-Reply-To: <1256115527-20635-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091021084826.GA29667@n2100.arm.linux.org.uk>
	<1256115527-20635-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20091101203240.GA18116@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Oct 21, 2009 at 10:58:47AM +0200, Uwe Kleine-K?nig wrote:
> CONFIG_MACH_ECO920 is enabled in at91rm9200dk_defconfig.  The name is
> wrong, but this is better than adding another defconfig or don't get
> compile coverage at all.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> Hello,
> 
> as pointed by Russell I included linux/gpio.h instead of mach/gpio.h.
Is this patch OK now, should I sent to the patch system even if
Jean-Christophe PLAGNIOL-VILLARD pointed out the defconfig stuff isn't
optimal?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
