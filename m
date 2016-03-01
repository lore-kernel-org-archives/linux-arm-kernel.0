From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 Mar 2016 13:00:58 -0800
Subject: [PATCH v3 5/5] ARM: dts: DRA7: Add dt nodes for PWMSS
In-Reply-To: <20160229232443.GW13417@atomide.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
 <1456439796-28546-6-git-send-email-fcooper@ti.com>
 <20160229232443.GW13417@atomide.com>
Message-ID: <20160301210057.GC4469@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [160229 15:25]:
> * Franklin S Cooper Jr <fcooper@ti.com> [160225 14:37]:
> > From: Vignesh R <vigneshr@ti.com>
> > 
> > Add PWMSS device tree nodes for DRA7 SoC family and add documentation
> > for dt bindings.
> 
> Seems to be all standard so applying this one into omap-for-v4.6/dt
> thanks.

Except this may still need to change depending on the hwmod
related patch as pointed out by Paul. So I've reverted this
in omap-for-v4.6/dt.

Regards,

Tony
