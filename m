From: arun.murthy@stericsson.com (Arun MURTHY)
Date: Wed, 6 Oct 2010 05:46:02 +0200
Subject: [PATCHv2 0/7] PWM core driver for pwm based led and backlight
	driver
In-Reply-To: <87wrpwu1cw.fsf@deeprootsystems.com>
References: <1286280002-1636-1-git-send-email-arun.murthy@stericsson.com>
	<87wrpwu1cw.fsf@deeprootsystems.com>
Message-ID: <F45880696056844FA6A73F415B568C6953571D4EFD@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Arun Murthy <arun.murthy@stericsson.com> writes:
> 
> > PWM core driver for pwm based led and backlight driver.
> > The intention of the pwm core driver is not to break the build if two
> or more
> > pwm drivers are enabled.
> > Align the existing pwm drivers to make use of the pwm core driver
> 
> Hi Arun,
> 
> Because you have Bill Gatliff on Cc, I'm guessing you've already looked
> at his RFC for a generic PWM framework?
> 
> There's recently been a proposal on DaVinci that is similar to yours
> that enables multiple PWM drivers, but it would be nice to have a
> common
> framework for this, and what Bill has proposed seems to be a good
> solution.
> 
Thanks for the information. This patch set of implementing pwm core driver
is aligned with the one in Davinci. Davinci pwm devices can make use of this
core driver framework.

Thanks and Regards,
Arun R Murthy
-------------
