From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Apr 2013 10:30:53 -0700
Subject: [RFC PATCH 0/3] ARM: OMAP2+: Add command line parameter for
 debugSS module control
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC281C1@DBDE01.ent.ti.com>
References: <hvaibhav@ti.com>
 <1362396957-30113-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EC281C1@DBDE01.ent.ti.com>
Message-ID: <20130408173052.GR10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [130314 04:33]:
> > From: Hiremath, Vaibhav
> > This patch introduces new kernel parameter "omap_debugss_en",
> > which will allow user to control debugSS module enable/disable
> > part during boot-time.
> > 
> > In case of OMAP3, the debugSS is part of EMU domain and
> > is currently controlled by clock tree alone.
> > 
> > In case of OMAP4, the debugSS is part of EMU domain and
> > is currently controlled by clock tree, as MODULEMODE_SWCTRL
> > is not defined for hwmod.
> > 
> > In case of AM335x, the debugSS is in wakeup domain and is currently
> > controlled through hwmod alone. Currently we keep it always enabled.
> 
> Any comments or input on this patch series?

No comments on adding the clocks, but the enabling of
them should be just a regular device driver.

Regards,

Tony
