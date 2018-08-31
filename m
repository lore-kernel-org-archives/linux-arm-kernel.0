From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 31 Aug 2018 10:48:54 +0200
Subject: [PATCH v3 14/30] dt-bindings: update the Allwinner GPADC device
 tree binding for H3 & A83T
In-Reply-To: <20180830154518.29507-15-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-15-embed3d@gmail.com>
Message-ID: <20180831084854.q2uh63pw5vprqlzt@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 05:45:02PM +0200, Philipp Rossak wrote:
> Allwinner H3 features a thermal sensor like the one in A33, but has its
> register re-arranged, the clock divider moved to CCU (originally the
> clock divider is in ADC) and added a pair of bus clock and reset.
> 
> Allwinner A83T features a thermal sensor similar to the H3, the ths clock,
> the bus clock and the reset was removed from the CCU. The THS in A83T
> has a clock that is directly connected and runs with 24 MHz.
> 
> Update the binding document to cover H3 and A83T.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>

You probably want to have a look at:
https://www.spinics.net/lists/arm-kernel/msg670167.html

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180831/2d963fdc/attachment.sig>
