From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 19 May 2011 21:56:32 +0800
Subject: [PATCH 02/10] mach-u300: rewrite gpio driver, move to drivers/gpio
In-Reply-To: <BANLkTinD9rAipfwNnh6QpgbcogckdtQ=OQ@mail.gmail.com>
References: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
	<20110519085638.GA26816@S2100-06.ap.freescale.net>
	<BANLkTinD9rAipfwNnh6QpgbcogckdtQ=OQ@mail.gmail.com>
Message-ID: <20110519135631.GB26816@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2011 at 02:21:27PM +0200, Linus Walleij wrote:
> On Thu, May 19, 2011 at 10:56 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> 
> > I start working on moving mxs gpio (arch/arm/mach-mxs/gpio.c) into
> > driver/gpio, and I see the possibility to go a different approach
> > from U300 one posted here.
> 
> I've tried to figure out what relation the mail has to the U300 driver
> but cannot find any, more than that it's moving a driver... Please
> start a new mail thread.
> 
I will post mxs-gpio driver once I get it done.  Then please review
the code and see the difference between mxs-gpio and u300-gpio,
though these hardwares have something in common.

-- 
Regards,
Shawn
