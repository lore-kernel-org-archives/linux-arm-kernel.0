From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Oct 2009 21:01:50 +0200
Subject: list of apparently(?) un-included header files under arch/arm
In-Reply-To: <20090930164102.GA4128@mail.gnudd.com>
References: <alpine.LFD.2.00.0909301126360.18347@localhost>
	<20090930164102.GA4128@mail.gnudd.com>
Message-ID: <20091004190149.GG1378@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2009-09-30 18:41:03, Alessandro Rubini wrote:
> > ./arch/arm/mach-at91/include/mach/at91_adc.h
> > ./arch/arm/mach-at91/include/mach/at91_spi.h
> > ./arch/arm/mach-at91/include/mach/at91_ssc.h
> 
> These at least are useful. I've used the ADC some time ago, and not
> having to redefine register is good. And when someone will write
> corresponding drivers for the kernel, the header is already there.

Well... unless someone is already working on such driver, they should
be removed. Interested persons can pull them out of history...
   
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
