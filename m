From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 Jan 2011 08:54:08 +0100
Subject: [RFC] add pwmlib support
In-Reply-To: <F45880696056844FA6A73F415B568C6953739F1986@EXDCVYMBSTM006.EQ1STM.local>
References: <1296217283-14531-1-git-send-email-s.hauer@pengutronix.de>
	<4D447E5E.6060007@metafoo.de>
	<F45880696056844FA6A73F415B568C6953739F1986@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <20110131075408.GH9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 31, 2011 at 04:35:33AM +0100, Arun MURTHY wrote:
> Hi Sascha,
> 
> > > I Cced the people working with PWMs in the kernel in the hope that
> > they can
> > > give input on what's missing / wrong in this implementation
> > >
> > > Sascha
> > >
> > 
> > Hi
> > 
> > There have been two other proposals for a generic PWM api during the
> > last year.
> > You might want to take a look at them.
> > 
> > https://lkml.org/lkml/2010/2/9/275
> > https://lkml.org/lkml/2010/9/28/107
> > 
> > I've added Bill Gatliff and Arun Murthy to Cc.
> > 
> 
> As said by Lars, we already have developed the pwm core driver and
> progressing towards aligning the existing pwm drivers to the pwm core
> driver.
> These set of patches are expected to be out in LKML by this week.

Nice, problem solved without me having to work on it ;). Please consider
Ccing linux-arm-kernel as many of your potential users are following this
list.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
