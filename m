From: j-keerthy@ti.com (J, KEERTHY)
Date: Wed, 13 Feb 2013 04:59:17 +0000
Subject: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
In-Reply-To: <alpine.DEB.2.00.1302122028480.29149@utopia.booyaka.com>
References: <1359966525-7603-1-git-send-email-j-keerthy@ti.com>
 <alpine.DEB.2.00.1302080248550.8539@utopia.booyaka.com>
 <DC88CAD03C0052499C1907B327FC63229B92FF@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302081805450.28008@utopia.booyaka.com>
 <alpine.DEB.2.00.1302081855370.28008@utopia.booyaka.com>
 <DC88CAD03C0052499C1907B327FC63229B966E@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302111538430.8260@utopia.booyaka.com>
 <DC88CAD03C0052499C1907B327FC63229B989B@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302120638580.14983@utopia.booyaka.com>
 <DC88CAD03C0052499C1907B327FC63229B98DD@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302122028480.29149@utopia.booyaka.com>
Message-ID: <DC88CAD03C0052499C1907B327FC63229BAB0B@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Wednesday, February 13, 2013 2:19 AM
> To: J, KEERTHY
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
> 
> On Tue, 12 Feb 2013, J, KEERTHY wrote:
> 
> > Heh :-). It narrowed down to this patch:
> >
> > commit 17b7e7d33530e2bbd3bdc90f4db09b91cfdde2bb
> > Author: Paul Walmsley <paul@pwsan.com>
> > Date:   Sat Jan 26 00:48:54 2013 -0700
> >
> >     ARM: OMAP4: clock/hwmod data: start to remove some IP block
> control "clocks"
> 
> Thanks, this fixes it:
> 
> http://marc.info/?l=linux-omap&m=136070089529743&w=2
> 
Ok. Cool.

> But at this point, I've rescheduled your patch to the 3.10-cleanup time
> frame, since we're pretty close to the 3.9 merge window.
>

So the patch needs to be rebased after 3.9 right?

> 
> - Paul
