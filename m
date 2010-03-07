From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 7 Mar 2010 09:23:44 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267716956.6526.491.camel@e102109-lin.cambridge.arm.com>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267316072.23523.1842.camel@pasglop>
	<1267333263.2762.11.camel@mulgrave.site>
	<20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<20100303215437.GF2579@ucw.cz>
	<1267709756.6526.380.camel@e102109-lin.cambridge.arm.com>
	<20100304135128.GA12191@atrey.karlin.mff.cuni.cz>
	<1267716956.6526.491.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100307082344.GB1987@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Seems like ARM has requirement other architectures do not, that is
> > a) not documented anywhere
> > b) causes problems
> 
> Well, ARM is pretty similar to other architectures in this respect. And
> I'm sure other architectures have similar problems, only that they only
> become visible in some circumstances they may not have encountered (i.e.
> PIO drivers + filesystem that doesn't call flush_dcache_page like ext*).
> Some other architectures may do heavier flushing
> 
> Of course, a Documentation/arm/cachetlb.txt file would make sense.

Actually, short/simple documentation for driver authors would be even
better. Then you can claim it is bug in driver :-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
