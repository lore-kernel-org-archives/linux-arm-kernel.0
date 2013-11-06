From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 6 Nov 2013 22:52:31 +0800
Subject: [RFC PATCH 3/3] ARM: imx: cpuidle: Move the drivers to
 drivers/cpuidle
In-Reply-To: <20131106072132.GE24559@pengutronix.de>
References: <1382978973-4034-1-git-send-email-daniel.lezcano@linaro.org>
 <1382978973-4034-3-git-send-email-daniel.lezcano@linaro.org>
 <20131106072132.GE24559@pengutronix.de>
Message-ID: <20131106145228.GC4352@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 08:21:33AM +0100, Sascha Hauer wrote:
> Daniel,
> 
> On Mon, Oct 28, 2013 at 09:49:33AM -0700, Daniel Lezcano wrote:
> > +
> > +config ARM_IMX5_CPUIDLE
> > +        bool "Cpu Idle Driver for the IMX5 processors"
> > +	default y
> > +	depends on SOC_IMX5 
> > +	help
> > +	  Select this to enable cpuidle for IMX5 processors
> > +
> > +config ARM_IMX6Q_CPUIDLE
> > +        bool "Cpu Idle Driver for the IMX6Q processors"
> > +	default y
> > +	depends on SOC_IMX6Q
> > +	help
> > +	  Select this to enable cpuidle for IMX6Q processors
> 
> I can't say much to this series except there's some whitespace damage
> here. Please resend this series with Cc: Shawn Guo <shawn.guo@linaro.org>

I like it in general.  Will take a deep look and test it on hardware
tomorrow.

Shawn
