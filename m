From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 11 Apr 2010 09:53:00 +0200
Subject: [Zaurus-devel] [regression] 2.6.34-rc1 to -rc3 on zaurus: no
	longer boots
In-Reply-To: <20100408204204.GA26902@elf.ucw.cz>
References: <20100408110533.GA14451@atrey.karlin.mff.cuni.cz>
	<20100408154749.GE3269@jama> <20100408204204.GA26902@elf.ucw.cz>
Message-ID: <20100411075300.GC1534@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > It is Zaurus SL-C3000 (aka spitz). I'm using kexec, but that used to
> > > work. Should I try minimal config?
> > 
> > FYI:
> > 
> > I've just booted on my spitz 2.6.34-rc3 built with OE (config from Andrea), then kexec to 2.6.33.
> > http://git.openembedded.org/cgit.cgi/openembedded/commit/?id=adadb0343015894e33032b53d87e3e03a368a594
> > 

Ok, so I could only find 

> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.33-rc6
> # Tue Feb  9 22:56:42 2010
> #

33-rc6 config there. I tried my best answers, and got config
(attached), but that one still does not boot :-(.
								Pavel
 
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
