From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 28 Aug 2011 11:35:26 +0200
Subject: zaurus patches -- arm/pxa -- is Eric alive
In-Reply-To: <20110711140303.GA32532@atrey.karlin.mff.cuni.cz>
References: <20110711134150.GA15506@localhost.ucw.cz>
	<CALT56yM+fNs_2QorWK0=gr2um1H3vDX+HXPCi9bmKDdOdSvptA@mail.gmail.com>
	<20110711140303.GA32532@atrey.karlin.mff.cuni.cz>
Message-ID: <20110828093526.GA17995@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > There are some rather critical patches for zaurus C-3000 (spitz)
> > > available... with no response. What is going on?
> > 
> > Eric seems alive. At least he've sent pull requests few days ago.
> > Maybe you can point to those patches, that you mention as critical?
> 
> Perhaps the most critical one is:
> 
> [PATCH] MAX1111: Fix race condition causing NULL pointer exception
> 
> http://ns1.yosemitephotos.net/lists/arm-kernel/msg125356.html

> Which fixes memory corruption that caused random oops.

This one is in 3.1-rc3. Good.

> And then there is a bunch of fixes for charging and power management from
> Pavel Machek:
> 
> Disable CF during suspend
> 
> https://lkml.org/lkml/2011/5/21/46

This one is not. Could we get it pushed?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
