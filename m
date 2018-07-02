From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 Jul 2018 04:21:12 -0700
Subject: [PATCH] ARM: DTS: dra7: fix DCAN node addresses
In-Reply-To: <20180523190143.GV98604@atomide.com>
References: <20180521200832.24213-1-khilman@baylibre.com>
 <cf431fca-0372-bd50-88e7-d478e4aa52da@ti.com>
 <20180523190143.GV98604@atomide.com>
Message-ID: <20180702112112.GT112168@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [180523 19:04]:
> * Roger Quadros <rogerq@ti.com> [180521 20:25]:
> > On 21/05/18 15:08, Kevin Hilman wrote:
> > > Fix the DT node addresses to match the reg property addresses,
> > > which were verified to match the TRM:
> > > http://www.ti.com/lit/pdf/sprui30
> > > 
> > > Cc: Roger Quadros <rogerq@ti.com>
> > > Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> > 
> > Thanks Kevin.
> > 
> > Acked-by: Roger Quadros <rogerq@ti.com>
> 
> Applying into omap-for-v4.18/dt-fixes thanks.

Oops sorry looks like I forgot to send a pull request for
this one during the merge window. As we're already at -rc3,
I'll just merge it into omap-for-v4.19/fixes-not-urgent.

Regards,

Tony
