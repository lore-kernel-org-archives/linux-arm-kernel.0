From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 1 Mar 2011 10:04:12 +0100
Subject: [PATCH 1/2] ARM imx53: add pwm devices support
In-Reply-To: <AANLkTin5SCtSZfFhErb9baWpMioDWk=UA15cOddb1B=R@mail.gmail.com>
References: <1298961018-8988-1-git-send-email-b02280@freescale.com>
	<20110301081043.GS22310@pengutronix.de>
	<AANLkTin5SCtSZfFhErb9baWpMioDWk=UA15cOddb1B=R@mail.gmail.com>
Message-ID: <20110301090412.GU22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 04:21:37PM +0800, Eric Miao wrote:
> >> ?config IMX_HAVE_PLATFORM_MXC_PWM
> >> ? ? ? bool
> >> + ? ? default y if ARCH_MX21 || ARCH_MX25 || SOC_IMX27 || SOC_IMX51 || SOC_IMX53
> > If you do this, can you please use SOC_IMX21 and SOC_IMX25? ?Or maybe
> > even def_bool y?
> >
> 
> Or the other way, in config SOC_IMX53, select IMX_HAVE_PLATFORM_MXC_PWM?
Yeah, that's how most of the other IMX_HAVE_PLATFORM_XYZ work.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
