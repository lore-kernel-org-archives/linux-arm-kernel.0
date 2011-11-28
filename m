From: B29397@freescale.com (Chen Peter-B29397)
Date: Mon, 28 Nov 2011 09:02:57 +0000
Subject: Want to Get Suggestion for MX28 USB Submisson
In-Reply-To: <20111128081741.GH3869@pengutronix.de>
References: <35AB98346D25394A9354ED89C4D76587225CFF@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111128070821.GD3869@pengutronix.de>
 <35AB98346D25394A9354ED89C4D76587225E7D@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111128081741.GH3869@pengutronix.de>
Message-ID: <35AB98346D25394A9354ED89C4D76587225ED6@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> -----Original Message-----
> From: linux-usb-owner at vger.kernel.org [mailto:linux-usb-
> owner at vger.kernel.org] On Behalf Of Robert Schwebel
> Sent: Monday, November 28, 2011 4:18 PM
> To: Chen Peter-B29397
> Cc: linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> gregkh at suse.de; stern at rowland.harvard.edu; kernel at pengutronix.de;
> shawn.guo at linaro.org; eric.y.miao at gmail.com; Li Frank-B20596; Lin Tony-
> B19295
> Subject: Re: Want to Get Suggestion for MX28 USB Submisson
> 
> On Mon, Nov 28, 2011 at 08:10:14AM +0000, Chen Peter-B29397 wrote:
> > > - help to mainline Heikki's patches (port your platform, help testing)
> > > - let's improve the ci13xxx driver for i.MX.
> >
> > Robert, thanks for your suggestion, I just wonder if it will cause
> > mx28 usb upstream a little later?
> 
> Well, if the quality of the code improves, it will be worth it. Note
> that this is already unmaintainable: if you don't believe it, look at
> the git log for the four different drivers and you'll notice that a lot
> of bugs and improvements do not make their way into all of the drivers.
> 

Submit a new driver with new platform may not an easy life. 
Anyway, I will mostly follow your suggestion if others have no better suggestion. 

> rsc
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> |
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
