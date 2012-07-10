From: pavel@denx.de (Pavel Machek)
Date: Tue, 10 Jul 2012 11:48:57 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <4FFADBBD.4060906@gmail.com>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-2-git-send-email-dinguyen@altera.com>
 <4FF483D2.70000@gmail.com> <20120709113021.GB12130@elf.ucw.cz>
 <4FFADBBD.4060906@gmail.com>
Message-ID: <20120710094857.GG10225@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2012-07-09 08:25:17, Rob Herring wrote:
> On 07/09/2012 06:30 AM, Pavel Machek wrote:
> > Hi!
> > 
> >>> +config ARCH_SOCFPGA
> >>> +	bool "Altera SOCFPGA family"
> >>> +	select CPU_V7
> >>> +	select ARM_GIC
> >>> +	select ARM_AMBA
> >>> +	select CLKDEV_LOOKUP
> >>> +	select MIGHT_HAVE_CACHE_L2X0
> >>> +	select HAVE_MACH_CLKDEV
> >>> +	select GENERIC_CLOCKEVENTS
> >>> +	select ARCH_WANT_OPTIONAL_GPIOLIB
> >>> +	select GPIO_PL061 if GPIOLIB
> >>> +	select NEED_MACH_MEMORY_H
> >>> +	select USE_OF
> >>
> >> Alphabetize the selects.
> > 
> > Umm... Others are not alphabetized, either. Something like this to
> > group them logically?
> 
> Many are not, but check any relatively new platform like highbank, zynq,
> picoxcell.

Ok, done, thanks. (Will push via git to Dinh, should appear in next
version).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
