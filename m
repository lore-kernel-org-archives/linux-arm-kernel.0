From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 8 Dec 2009 11:16:00 +0100
Subject: [PATCH 2/3] staging/dream: add missing include files
In-Reply-To: <20091120110728.GB10644@n2100.arm.linux.org.uk>
References: <20091101222717.GB20740@elf.ucw.cz>
	<20091119225602.GC18710@kroah.com>
	<20091120105726.GH11212@elf.ucw.cz>
	<20091120110728.GB10644@n2100.arm.linux.org.uk>
Message-ID: <20091208101559.GF12264@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2009-11-20 11:07:28, Russell King - ARM Linux wrote:
> On Fri, Nov 20, 2009 at 11:57:26AM +0100, Pavel Machek wrote:
> > On Thu 2009-11-19 14:56:02, Greg KH wrote:
> > > On Sun, Nov 01, 2009 at 11:27:17PM +0100, Pavel Machek wrote:
> > > > +config GENERIC_GPIO
> > > > +	bool
> > > > +	default y
> > > 
> > > Which breaks the i386 build.  Don't force on a general config option
> > > like this, that's not nice at all :(
> > 
> > Ok, I should figure out how to limit it to arch-msm.
> 
> You do it by 'select'ing the symbol in arch/arm/Kconfig.  See the many
> other examples therein of how to do it.

Thanks.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
