From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 10 Nov 2009 14:25:26 +0100
Subject: spitz battery driver
In-Reply-To: <1257856464.6394.6.camel@utx.utx.cz>
References: <20091109135813.GA1385@ucw.cz>
	<f17812d70911091948p5331f11djc887443559b233db@mail.gmail.com>
	<20091110104634.GA1395@ucw.cz> <1257856464.6394.6.camel@utx.utx.cz>
Message-ID: <20091110132526.GC26144@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

k
> > > This is a good move. However, I assume the patch is still RFC now.
> > > Or basically the coding style cleanup can be separated into another
> > > patch?
> > 
> > Its rfc now. Parts of codingstyle cleanup should already be in your
> > tree, I'll rediff it later.
> 
> Pavel, could you compare your patch with the "power: implement platform
> battery driver"??? patches from Paul Fertser just sent to LKML and
> zaurus-devel list? Would it be complicated to migrate to it? I guess

Complicated? No. Useful? Probably also no. Remove 50 lines for
additional indirection? I'd prefer not to.

> that use of platform driver could allow to recycle major parts of the
> charging driver by more devices.

take a look at those patches. I'd rather use mainline battery api.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
