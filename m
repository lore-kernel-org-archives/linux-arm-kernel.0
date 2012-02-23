From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Feb 2012 09:16:30 +0000
Subject: [PATCH 1/3] arm: ignore devicetree blobs.
In-Reply-To: <20120222222619.GY14173@pengutronix.de>
References: <cover.1312906908.git.jason@lakedaemon.net>
 <cover.1329936660.git.jason@lakedaemon.net>
 <3629df9b5b96d3a3a63a34ebf6ddfca2fd72ccfc.1329936660.git.jason@lakedaemon.net>
 <20120222222619.GY14173@pengutronix.de>
Message-ID: <20120223091630.GA2036@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 11:26:19PM +0100, Uwe Kleine-K?nig wrote:
> On Wed, Feb 22, 2012 at 07:18:44PM +0000, Jason Cooper wrote:
> > 
> > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> /me claims prior art:
> 
> 	http://mid.gmane.org/1323808612-14976-1-git-send-email-u.kleine-koenig at pengutronix.de

Multiple people proposed this...

Grant accepted my patch, and it is already in -next:

See next-20110222

810ae3d26507e61d1f7a69e9716443df1ce41449
ARM: devicetree: Add .dtb files to arch/arm/boot/.gitignore

Cheers
---Dave

> 
> Best regards
> Uwe
> 	
> > ---
> > NOTE: This is the first version of this patch, so no change history.
> > 
> >  arch/arm/boot/.gitignore |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/.gitignore b/arch/arm/boot/.gitignore
> > index ce1c5ff..3c79f85 100644
> > --- a/arch/arm/boot/.gitignore
> > +++ b/arch/arm/boot/.gitignore
> > @@ -3,3 +3,4 @@ zImage
> >  xipImage
> >  bootpImage
> >  uImage
> > +*.dtb
> > -- 
> > 1.7.3.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
