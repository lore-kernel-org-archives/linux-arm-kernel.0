From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 28 Sep 2013 10:43:28 +0200
Subject: new binutils needed for arm in 3.12-rc1
In-Reply-To: <1380235709.1974.93@driftwood>
References: <alpine.LFD.2.03.1309251147320.312@syhkavp.arg>
 <1380235709.1974.93@driftwood>
Message-ID: <20130928084328.GA5649@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >Given you're not upgrading your binutils anymore that means
> >you'll have to apply that patch only once instead of having to
> >apply it
> >to every kernel upgrade.
> 
> Indeed. Patching my own toolchain isn't really a problem. My
> objection was to the Documentation patch telling the world at large
> that for all targets, older binutils aren't supported even on x86.
> That was worth pushing back against.
> 
> I don't indend to use old gcc/binutils versions forever, I just want
> to be able to use them until I can replace them with llvm or
> similar.

So, what is the proposal? Just ignore the problem and make people
wonder why their arm kernels are not compiling?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
