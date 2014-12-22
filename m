From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Dec 2014 16:51:51 +0000
Subject: [PATCH v3 5/5] ASoC: dwc: Add documentation for I2S DT
In-Reply-To: <54983E0A.2050005@arm.com>
References: <cover.1418826016.git.Andrew.Jackson@arm.com>
 <2842090b2c7a8a98aed0cfa02addcef0b2e8ec6b.1418826016.git.Andrew.Jackson@arm.com>
 <20141222142636.GT17800@sirena.org.uk> <54983E0A.2050005@arm.com>
Message-ID: <20141222165151.GB17800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 03:51:38PM +0000, Andrew Jackson wrote:
> On 12/22/14 14:26, Mark Brown wrote:

> > This is a name based lookup of clocks but the code doesn't use
> > apb_pclk at all; it needs to or the binding needs to say that apb_pclk
> > must be the first listed clock (which would not be good).

> I can remove apb_pclk: I was modelling the device tree entry on 
> various PLxxx examples (c.f. amba-pl011) which also reference an AMBA clock
> but don't use it.  (The effect being to document what clock the block is
> driven by.)

With the AMBA devices the AMBA core manages the bus clock for the
drivers IIRC.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141222/0da82ee1/attachment.sig>
