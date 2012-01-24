From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Jan 2012 11:45:43 +0000
Subject: ARM/ARM-SoC plans for v3.4 merge window
In-Reply-To: <20120124112745.GT16726@n2100.arm.linux.org.uk>
References: <20120123114902.GY1068@n2100.arm.linux.org.uk>
 <20120124095009.GS16726@n2100.arm.linux.org.uk>
 <20120124105645.GE19798@mudshark.cambridge.arm.com>
 <20120124112745.GT16726@n2100.arm.linux.org.uk>
Message-ID: <20120124114543.GG19798@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 11:27:45AM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 24, 2012 at 10:56:45AM +0000, Will Deacon wrote:
> > I took a look at your amba branch, but all I can see in there is:
> > 
> > 6cfa627 ARM: 7079/1: spi: Fix builderror in spi-pl022.c
> > 1c3be36 PM: add runtime PM support to MMCI
> > 92b97f0 PM: add runtime PM support to core Primecell driver
> > 
> > which don't seem to touch Versatile or Realview. Am I looking in the wrong
> > place?
> 
> Erm, I don't think you're looking at the right branch - especially as
> all the commits start "ARM: amba:".  They were sent out to the mailing
> list on 20th Jan as a set of 31 patches (latest first):

[...]

Indeed, the amba branch I was looking at no longer exists on your server and
a git prune removed it. I'll take a look at the guys in devel-3.3 instead.

Thanks,

Will
