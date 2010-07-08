From: david.jander@protonic.nl (David Jander)
Date: Thu, 8 Jul 2010 09:28:36 +0200
Subject: i.MX51 kernel trees: Where to start?
In-Reply-To: <20100708054436.GC25143@jasper.tkos.co.il>
References: <201007071408.50621.david.jander@protonic.nl>
	<20100708054436.GC25143@jasper.tkos.co.il>
Message-ID: <201007080928.36618.david.jander@protonic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Baruch,

Thanks a lot for your reply.

On Thursday 08 July 2010 07:44:36 am Baruch Siach wrote:
> If you want to go with the mainline kernel then the place where i.MX
> development is happening is
> http://git.pengutronix.de/?p=imx/linux-2.6.git;a=summary

Is there a way of finding out exactly which peripherals of the i.MX51 are 
currently supported in this tree?
The master seems almost 2 months old, is there no ongoing porting work 
anymore, or is it all going into "for-next"?

> > What other trees are there, and how can I get an impression of the state
> > of each one?  How far are effords for mainline inclusion of the freescale
> > patches?
> 
> Freescale are doing very little to push their work for mainline inclusion.

That doesn't surprise me anymore, although I get the impression that they have 
learned at least a little bit form past lessons, since they are now at least 
"using" git ;-)

> Amit Kucheria from Canonical/Linaro has been doing some work on the i.MX5
> front. This work is in the mainline kernels since 2.6.34.

Sounds great... I'll need to figure out in what state the drivers for each 
peripheral are. Any hint other than just trying out?

> > 2.- Using this kernel, I notice the touchscreen driver, (mxc_ts.c) not
> > working correctly. It looks like it works for a few seconds after boot,
> > and then starts delaying samples very much, to the point that it is
> > unusable. Is this a known problem? Is there someone working on this?
> > Should I use another driver?
> 
> This driver is not in the mainline kernel, so the help you may get from
>  kernel developers is limited. In any case, questions about the input
>  subsystem should go to the linux-input mailing list
>  (linux-input at vger.kernel.org).

Thanks for the tip. If I get serious plans in porting that driver, I'll 
contact that list.

Best regards,

-- 
David Jander
Protonic Holland.
