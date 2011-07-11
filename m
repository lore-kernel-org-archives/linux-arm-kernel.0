From: metan@ucw.cz (Cyril Hrubis)
Date: Mon, 11 Jul 2011 16:03:03 +0200
Subject: zaurus patches -- arm/pxa -- is Eric alive
In-Reply-To: <CALT56yM+fNs_2QorWK0=gr2um1H3vDX+HXPCi9bmKDdOdSvptA@mail.gmail.com>
References: <20110711134150.GA15506@localhost.ucw.cz>
	<CALT56yM+fNs_2QorWK0=gr2um1H3vDX+HXPCi9bmKDdOdSvptA@mail.gmail.com>
Message-ID: <20110711140303.GA32532@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> > There are some rather critical patches for zaurus C-3000 (spitz)
> > available... with no response. What is going on?
> 
> Eric seems alive. At least he've sent pull requests few days ago.
> Maybe you can point to those patches, that you mention as critical?

Perhaps the most critical one is:

[PATCH] MAX1111: Fix race condition causing NULL pointer exception

http://ns1.yosemitephotos.net/lists/arm-kernel/msg125356.html

Which fixes memory corruption that caused random oops.

And then there is a bunch of fixes for charging and power management from
Pavel Machek:

Disable CF during suspend

https://lkml.org/lkml/2011/5/21/46

and spitz pm

https://lkml.org/lkml/2011/5/21/72
https://lkml.org/lkml/2011/5/21/73
https://lkml.org/lkml/2011/5/21/76

-- 
metan
