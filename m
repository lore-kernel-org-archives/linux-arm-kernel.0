From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Dec 2015 10:45:58 -0800
Subject: [PATCH v5 4/5] ARM: dts: DRA7: add entry for qspi mmap region
In-Reply-To: <20151211150935.GA15654@rob-hp-laptop>
References: <1449807000-6457-1-git-send-email-vigneshr@ti.com>
 <1449807000-6457-5-git-send-email-vigneshr@ti.com>
 <20151211150935.GA15654@rob-hp-laptop>
Message-ID: <20151217184557.GC23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [151211 07:10]:
> On Fri, Dec 11, 2015 at 09:39:59AM +0530, Vignesh R wrote:
> > Add qspi memory mapped region entries for DRA7xx based SoCs. Also,
> > update the binding documents for the controller to document this change.
> > 
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> 
> Acked-by: Rob Herring <robh@kernel.org>

Vignes, are patches 4 and 5 safe to apply separately already or
do things break if we do that?

Regards,

Tony
