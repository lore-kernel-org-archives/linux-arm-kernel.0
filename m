From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 9 Feb 2018 10:55:09 +0800
Subject: [PATCH] ARM: dts: ls1021a: add quadspi node
In-Reply-To: <43c533e2-2b93-9672-3905-5f4ba8d6db19@prevas.dk>
References: <20180126142014.13819-1-rasmus.villemoes@prevas.dk>
 <20180205080323.GP31354@dragon>
 <43c533e2-2b93-9672-3905-5f4ba8d6db19@prevas.dk>
Message-ID: <20180209025507.GI31910@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 08, 2018 at 03:24:40PM +0100, Rasmus Villemoes wrote:
> On 2018-02-05 09:03, Shawn Guo wrote:
> > On Fri, Jan 26, 2018 at 03:20:14PM +0100, Rasmus Villemoes wrote:
> >> Add a node to device tree repesenting the QuadSPI controller present on
> >> LS1021a. Driver support has been present since e8c034b2fbe5 (mtd:
> >> spi-nor: fsl-quadspi: add support for ls1021a).
> >>
> >> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > 
> > Applied, thanks.
> > 
> 
> Sorry, I didn't know you already had a similar patch queued for 4.16
> (85f8ee78ab ARM: dts: ls1021a: Add support for QSPI with ls1021a SoC),
> so I have to ask you to unapply (or do you want me to send a revert?) -
> the ls1021a.dtsi in your imx/dt branch now has two almost-identical
> qspi: nodes.

Ah, I did not notice that either.  Patch dropped.


Shawn
