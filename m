From: metan@ucw.cz (Cyril Hrubis)
Date: Mon, 11 Jul 2011 16:22:10 +0200
Subject: zaurus patches -- arm/pxa -- is Eric alive
In-Reply-To: <20110711141712.GD11153@pengutronix.de>
References: <20110711134150.GA15506@localhost.ucw.cz>
	<CALT56yM+fNs_2QorWK0=gr2um1H3vDX+HXPCi9bmKDdOdSvptA@mail.gmail.com>
	<20110711140303.GA32532@atrey.karlin.mff.cuni.cz>
	<20110711141712.GD11153@pengutronix.de>
Message-ID: <20110711142210.GB32532@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> > > > There are some rather critical patches for zaurus C-3000 (spitz)
> > > > available... with no response. What is going on?
> > > 
> > > Eric seems alive. At least he've sent pull requests few days ago.
> > > Maybe you can point to those patches, that you mention as critical?
> > 
> > Perhaps the most critical one is:
> > 
> > [PATCH] MAX1111: Fix race condition causing NULL pointer exception
> > 
> > http://ns1.yosemitephotos.net/lists/arm-kernel/msg125356.html
> 
> Ahem, this one was opposed to. The right one seems to be:
> 
> http://ns1.yosemitephotos.net/lists/arm-kernel/msg125592.html
> 
> Note that it is a hwmon-driver and neither the apropriate list nor
> maintainers have been CCed. Eric cannot take this patch. Check
> MAINTAINERAS (or use scripts/get_maintainer.pl) to find the right people
> and this will increase chances to get your patch upstream a lot.

Right, CCing patch author.

-- 
metan
