From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Jan 2012 10:56:45 +0000
Subject: ARM/ARM-SoC plans for v3.4 merge window
In-Reply-To: <20120124095009.GS16726@n2100.arm.linux.org.uk>
References: <20120123114902.GY1068@n2100.arm.linux.org.uk>
 <20120124095009.GS16726@n2100.arm.linux.org.uk>
Message-ID: <20120124105645.GE19798@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Jan 24, 2012 at 09:50:09AM +0000, Russell King - ARM Linux wrote:
> Right, although it's out there - but I'd like to get the AMBA changes
> into it which are already conflicting the Samsung development.  So I'm
> going to hold off officially asking for people to include the baseline
> until this evening.  At that point, I will shut down my 'amba' branch
> and transfer that over; that means I won't be accepting any further
> acks etc for that work.
> 
> If you haven't acked changes in the amba branch (eg, to Versatile,
> Realview etc) then it'll soon be too late...

I took a look at your amba branch, but all I can see in there is:

6cfa627 ARM: 7079/1: spi: Fix builderror in spi-pl022.c
1c3be36 PM: add runtime PM support to MMCI
92b97f0 PM: add runtime PM support to core Primecell driver

which don't seem to touch Versatile or Realview. Am I looking in the wrong
place?

Cheers,

Will
