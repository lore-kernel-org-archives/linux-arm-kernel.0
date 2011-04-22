From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 22 Apr 2011 17:47:25 +0200
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <20110418170752.GQ16019@shareable.org>
References: <201104122052.17453.pwaechtler@mac.com>
	<BANLkTin0NMo7ZDrnTmBghYeRC9wxJu7zrw@mail.gmail.com>
	<20110412203303.GA16019@shareable.org>
	<20110418135243.GB1479@ucw.cz>
	<20110418170752.GQ16019@shareable.org>
Message-ID: <20110422154344.GA7526@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > ...but note that no existing  filesystem is safe on media such
> > as usb sticks, SD and CF cards...
> 
> Sadly.  Do you know by now if enough information is available now to
> make it possible even in principle?

> Alternatively, do you know if there's been much progress
> characterising particular manufacturers/parts/brands or identifiable
> characteristics etc. to find ones on which a power fail safe
> filesystem is possible, even if it's just in principle for the moment?

There's nice table somewhere. If at least size of "big block" (usually
4MB) is known, safe fs should be possible. OTOH 4MB commit block is
not going to be too efficient.

Plus, I was told new MMC standard has "write reliable" option...

> Sadly I know of a large number of systems using CF or cheap ATA SSDs
> that were installed assuming ext3 is reliable when they are powered
> off at the wall every day.  That's because a lot of people assume they
> are solid-state drop-in replacements for hard disks, as that is how
> they are advertised.

False advertising, I'm afraid. I wanter if SATA SSDs do better...?
								       Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
