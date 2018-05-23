From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 May 2018 12:01:43 -0700
Subject: [PATCH] ARM: DTS: dra7: fix DCAN node addresses
In-Reply-To: <cf431fca-0372-bd50-88e7-d478e4aa52da@ti.com>
References: <20180521200832.24213-1-khilman@baylibre.com>
 <cf431fca-0372-bd50-88e7-d478e4aa52da@ti.com>
Message-ID: <20180523190143.GV98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [180521 20:25]:
> On 21/05/18 15:08, Kevin Hilman wrote:
> > Fix the DT node addresses to match the reg property addresses,
> > which were verified to match the TRM:
> > http://www.ti.com/lit/pdf/sprui30
> > 
> > Cc: Roger Quadros <rogerq@ti.com>
> > Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> 
> Thanks Kevin.
> 
> Acked-by: Roger Quadros <rogerq@ti.com>

Applying into omap-for-v4.18/dt-fixes thanks.

Tony
