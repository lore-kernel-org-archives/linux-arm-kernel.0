From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Nov 2015 14:34:50 -0800
Subject: [PATCH v4 4/5] ARM: dts: DRA7: add entry for qspi mmap region
In-Reply-To: <20151130220102.GG23396@atomide.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
 <1448860515-28336-5-git-send-email-vigneshr@ti.com>
 <20151130220102.GG23396@atomide.com>
Message-ID: <20151130223449.GK23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [151130 14:03]:
> * Vignesh R <vigneshr@ti.com> [151129 21:16]:
> > Add qspi memory mapped region entries for DRA7xx based SoCs. Also,
> > update the binding documents for the controller to document this change.
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > ---
> > 
> > v4: No changes.
> 
> OK I'll apply patches 4 and 5 of this series into omap-for-v4.5/dt thanks.
> The rest should get merged via the MTD tree.

Actually ddropping them after looking at the IO ranges like I commented.

Regards,

Tony
