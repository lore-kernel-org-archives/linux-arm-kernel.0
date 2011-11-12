From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Nov 2011 23:01:57 +0000
Subject: [PATCH] ARM: Add lsxhl machine type to mach-types
In-Reply-To: <201111121702.15274.michael@walle.cc>
References: <1320699251-26115-1-git-send-email-michael@walle.cc>
 <201111121702.15274.michael@walle.cc>
Message-ID: <20111112230157.GB27746@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 12, 2011 at 05:02:15PM +0100, Michael Walle wrote:
> Am Montag 07 November 2011, 21:54:11 schrieb Michael Walle:
> > (Re-)add Buffalo Linkstation Pro LS-XHL machine type.
> > 
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
> >  arch/arm/tools/mach-types |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> > index 5bdeef9..d50917e 100644
> > --- a/arch/arm/tools/mach-types
> > +++ b/arch/arm/tools/mach-types
> > @@ -458,6 +458,7 @@ mityomapl138		MACH_MITYOMAPL138	
> MITYOMAPL138		2650
> >  guruplug		MACH_GURUPLUG		GURUPLUG		2659
> >  spear310		MACH_SPEAR310		SPEAR310		2660
> >  spear320		MACH_SPEAR320		SPEAR320		2661
> > +lsxhl			MACH_LSXHL		LSXHL			
> 2663
> >  aquila			MACH_AQUILA		AQUILA			
> 2676
> >  sheeva_esata		MACH_ESATA_SHEEVAPLUG	ESATA_SHEEVAPLUG	2678
> >  msm7x30_surf		MACH_MSM7X30_SURF	MSM7X30_SURF		2679
> 
> Hi Russell,
> 
> ping :)
> 
> fyi im working on a linux and uboot port on the linkstation ls-chlv2 and ls-
> xhl. unfortunately uboot is following linux' mach-types.h so i need to get 
> this into linux before my uboot support can be merged upstream.

Please read the comments at the top of the file:

# This is a cut-down version of the file; it contains only machines that
# are merged into mainline or have been edited in the machine database
# within the last 12 months.  References to machine_is_NAME() do not count!

It gives you the criteria for entries being removed from the file.

What guarantee do we have that support for this platform will be found
to be acceptable (in it's non-DT form) and will be accepted into mainline
(which is the basic requirement for the entry staying in the kernel's
version of this file.)
