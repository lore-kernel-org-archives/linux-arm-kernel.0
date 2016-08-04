From: kbeldan@baylibre.com (Karl Beldan)
Date: Thu, 4 Aug 2016 21:00:45 +0000
Subject: [PATCH] ARM: dts: da850: Add missing pin muxing for the UARTs
In-Reply-To: <m2eg64pchw.fsf@baylibre.com>
References: <20160804110656.25318-1-kbeldan@baylibre.com>
 <m2eg64pchw.fsf@baylibre.com>
Message-ID: <20160804210045.GD15013@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 12:20:27PM -0700, Kevin Hilman wrote:
> Karl Beldan <kbeldan@baylibre.com> writes:
> 
> > This adds 2 pinctrl groups (rtscts, rxtx) for each of the 3 UARTs.
> >
> > Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> 
> Should da850-evm be updated to use the serial2_rxtx_pins also?
> 
I could not find the EVM schematics on the net and I only have an LCDK,
but according to the code it should, however I can't tell whether flow
control pins are used.
 
Karl
