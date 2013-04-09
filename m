From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 9 Apr 2013 08:11:22 +0000
Subject: [RFC PATCH 0/3] ARM: OMAP2+: Add command line parameter for
 debugSS module control
In-Reply-To: <20130408173052.GR10155@atomide.com>
References: <hvaibhav@ti.com>
 <1362396957-30113-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EC281C1@DBDE01.ent.ti.com>
 <20130408173052.GR10155@atomide.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC47BD9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Monday, April 08, 2013 11:01 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap at vger.kernel.org; khilman at linaro.org; paul at pwsan.com;
> Nayak, Rajendra; linux-arm-kernel at lists.infradead.org
> Subject: Re: [RFC PATCH 0/3] ARM: OMAP2+: Add command line parameter
> for debugSS module control
> 
> * Hiremath, Vaibhav <hvaibhav@ti.com> [130314 04:33]:
> > > From: Hiremath, Vaibhav
> > > This patch introduces new kernel parameter "omap_debugss_en",
> > > which will allow user to control debugSS module enable/disable
> > > part during boot-time.
> > >
> > > In case of OMAP3, the debugSS is part of EMU domain and
> > > is currently controlled by clock tree alone.
> > >
> > > In case of OMAP4, the debugSS is part of EMU domain and
> > > is currently controlled by clock tree, as MODULEMODE_SWCTRL
> > > is not defined for hwmod.
> > >
> > > In case of AM335x, the debugSS is in wakeup domain and is currently
> > > controlled through hwmod alone. Currently we keep it always
> enabled.
> >
> > Any comments or input on this patch series?
> 
> No comments on adding the clocks, but the enabling of
> them should be just a regular device driver.
> 

Thanks for review, on this patch I will add your Reviewed-by line on next version
Of the patch-series.

I have just responded my comment to the other mail on this, and based on
Your response we can conclude. 

Thanks,
Vaibhav
.
