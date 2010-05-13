From: vishwanath.bs@ti.com (Sripathy, Vishwanath)
Date: Thu, 13 May 2010 17:15:57 +0530
Subject: [PATCHv2 1/2] ARM: VFP: Fixed suspend and added context save
	support
In-Reply-To: <AANLkTilErBCyRab33tfRfLouudkP3iRmgsKX58Z5CRM_@mail.gmail.com>
References: <1259847353-22725-1-git-send-email-tero.kristo@nokia.com>
	<1259847353-22725-2-git-send-email-tero.kristo@nokia.com>
	<AANLkTilyji16JTT1Oe8fOT6Oz5tzopQNc-3AIQ3UprCO@mail.gmail.com>
	<20100511212719.GC32186@n2100.arm.linux.org.uk>
	<AANLkTimKKwe-_kjiSlr3fVVy0Bi1krK8rmyT8-0L3B0d@mail.gmail.com>
	<AANLkTilErBCyRab33tfRfLouudkP3iRmgsKX58Z5CRM_@mail.gmail.com>
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703050DED97@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ack.

Regards
Vishwa

> -----Original Message-----
> From: ye janboe [mailto:janboe.ye at gmail.com]
> Sent: Thursday, May 13, 2010 2:44 PM
> To: Tero Kristo; Sripathy, Vishwanath; Nayak, Rajendra; Woodruff, Richard; peter.de-
> schrijver at nokia.com
> Cc: tony at atomide.com; linux-arm-kernel at lists.infradead.org; linux-
> omap at vger.kernel.org; Russell King - ARM Linux
> Subject: Re: [PATCHv2 1/2] ARM: VFP: Fixed suspend and added context save
> support
> 
> + peoples who are in CC list.
> 
> Janboe Ye
> 
> 2010/5/13 ye janboe <janboe.ye@gmail.com>:
> > Thanks for Russell and Tony.
> >
> > I think this patch is needed when MPU support OFF mode, special on
> > omap. Otherwise, VFP state will be lost.
> >
> > Reviewed-by: Janboe Ye <janboe.ye@gmail.com>
> >
> > 2010/5/12 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> >> On Tue, May 11, 2010 at 11:15:13AM +0800, ye janboe wrote:
> >>> Is this patch ignored by you? I do not see any ack for this patch.
> >>
> >> Patch is fine, shame some of the people on the Cc haven't acked it though.
> >> Can we get acks from anyone of those, and then submit it to the patch
> >> system?
> >>
> >>> > Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> >>> > Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
> >>> > Cc: Rajendra Nayak <rnayak@ti.com>
> >>> > Cc: Richard Woodruff <r-woodruff2@ti.com>
> >>> > Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> >>
> >
