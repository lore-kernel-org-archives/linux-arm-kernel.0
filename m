From: arun.murthy@stericsson.com (Arun MURTHY)
Date: Mon, 31 Jan 2011 04:35:33 +0100
Subject: [RFC] add pwmlib support
In-Reply-To: <4D447E5E.6060007@metafoo.de>
References: <1296217283-14531-1-git-send-email-s.hauer@pengutronix.de>
	<4D447E5E.6060007@metafoo.de>
Message-ID: <F45880696056844FA6A73F415B568C6953739F1986@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

> > I Cced the people working with PWMs in the kernel in the hope that
> they can
> > give input on what's missing / wrong in this implementation
> >
> > Sascha
> >
> 
> Hi
> 
> There have been two other proposals for a generic PWM api during the
> last year.
> You might want to take a look at them.
> 
> https://lkml.org/lkml/2010/2/9/275
> https://lkml.org/lkml/2010/9/28/107
> 
> I've added Bill Gatliff and Arun Murthy to Cc.
> 

As said by Lars, we already have developed the pwm core driver and
progressing towards aligning the existing pwm drivers to the pwm core
driver.
These set of patches are expected to be out in LKML by this week.

Thanks and Regards,
Arun R Murthy
------------
