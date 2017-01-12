From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 12 Jan 2017 11:54:05 +0100
Subject: [PATCH v2] Documentation: dt: reset: Revise typos in TI syscon
 reset example
In-Reply-To: <20170112012217.18115-1-s-anna@ti.com>
References: <20170109192814.26811-1-s-anna@ti.com>
 <20170112012217.18115-1-s-anna@ti.com>
Message-ID: <1484218445.2376.10.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 11.01.2017, 19:22 -0600 schrieb Suman Anna:
> Fix couple of typos in the example given in the TI syscon reset
> binding. The ti,reset-bits used for DSP0 are corrected to match
> the values that will be used in the actual DT node.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v2: Address Rob Herring's comment to change the reset node name
>     from "psc-reset" to "reset-controller"

I've applied the patch, thank you.

regards
Philipp
