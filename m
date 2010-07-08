From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 8 Jul 2010 10:57:57 +0300
Subject: i.MX51 kernel trees: Where to start?
In-Reply-To: <201007080928.36618.david.jander@protonic.nl>
References: <201007071408.50621.david.jander@protonic.nl>
	<20100708054436.GC25143@jasper.tkos.co.il>
	<201007080928.36618.david.jander@protonic.nl>
Message-ID: <20100708075756.GD25143@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Thu, Jul 08, 2010 at 09:28:36AM +0200, David Jander wrote:
> On Thursday 08 July 2010 07:44:36 am Baruch Siach wrote:
> > If you want to go with the mainline kernel then the place where i.MX
> > development is happening is
> > http://git.pengutronix.de/?p=imx/linux-2.6.git;a=summary
> 
> Is there a way of finding out exactly which peripherals of the i.MX51 are 
> currently supported in this tree?
> The master seems almost 2 months old, is there no ongoing porting work 
> anymore, or is it all going into "for-next"?

The for-next branch contains changes intended to go upstream in the next merge 
window. So, yes, that's where you find the new stuff.

[snip]

> > Amit Kucheria from Canonical/Linaro has been doing some work on the i.MX5
> > front. This work is in the mainline kernels since 2.6.34.
> 
> Sounds great... I'll need to figure out in what state the drivers for each 
> peripheral are. Any hint other than just trying out?

I guess that some of the i.MX51 peripherals are either identical or very close 
to those found in earlier i.MX chips, which already have drives in the 
mainline kernel. The only sure way to know which one works is to look at the 
chip Reference Manual, compare to the actual driver code, and test.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
