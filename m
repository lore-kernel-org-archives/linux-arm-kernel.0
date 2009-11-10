From: utx@penguin.cz (Stanislav Brabec)
Date: Tue, 10 Nov 2009 13:34:24 +0100
Subject: spitz battery driver
In-Reply-To: <20091110104634.GA1395@ucw.cz>
References: <20091109135813.GA1385@ucw.cz>
	<f17812d70911091948p5331f11djc887443559b233db@mail.gmail.com>
	<20091110104634.GA1395@ucw.cz>
Message-ID: <1257856464.6394.6.camel@utx.utx.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek wrote:
> On Tue 2009-11-10 11:48:16, Eric Miao wrote:

> > > This introduces battery driver for spitz. For now it is
> > > monitoring&debug-only.
> > >
> > 
> > This is a good move. However, I assume the patch is still RFC now.
> > Or basically the coding style cleanup can be separated into another
> > patch?
> 
> Its rfc now. Parts of codingstyle cleanup should already be in your
> tree, I'll rediff it later.

Pavel, could you compare your patch with the "power: implement platform
battery driver"? patches from Paul Fertser just sent to LKML and
zaurus-devel list? Would it be complicated to migrate to it? I guess
that use of platform driver could allow to recycle major parts of the
charging driver by more devices.


________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
