From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Dec 2015 08:42:00 -0800
Subject: [PATCH v5 4/5] ARM: dts: DRA7: add entry for qspi mmap region
In-Reply-To: <56739EB4.6040804@ti.com>
References: <1449807000-6457-1-git-send-email-vigneshr@ti.com>
 <1449807000-6457-5-git-send-email-vigneshr@ti.com>
 <20151211150935.GA15654@rob-hp-laptop>
 <20151217184557.GC23396@atomide.com> <56739EB4.6040804@ti.com>
Message-ID: <20151218164200.GM23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vignesh R <vigneshr@ti.com> [151217 21:51]:
> 
> 
> On 12/18/2015 12:15 AM, Tony Lindgren wrote:
> > * Rob Herring <robh@kernel.org> [151211 07:10]:
> >> On Fri, Dec 11, 2015 at 09:39:59AM +0530, Vignesh R wrote:
> >>> Add qspi memory mapped region entries for DRA7xx based SoCs. Also,
> >>> update the binding documents for the controller to document this change.
> >>>
> >>> Signed-off-by: Vignesh R <vigneshr@ti.com>
> >>
> >> Acked-by: Rob Herring <robh@kernel.org>
> > 
> > Vignes, are patches 4 and 5 safe to apply separately already or
> > do things break if we do that?
> 
> Yes, 4 and 5 can be applied separately w/o driver changes.

OK picking 4 and 5 into omap-for-v4.5/dt thanks.

Tony
