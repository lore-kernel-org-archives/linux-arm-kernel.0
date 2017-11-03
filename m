From: broonie@kernel.org (Mark Brown)
Date: Fri, 3 Nov 2017 20:11:50 +0000
Subject: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
In-Reply-To: <1509739759.5473.93.camel@impinj.com>
References: <20171027010841.28624-1-tpiepho@impinj.com>
 <20171027010841.28624-2-tpiepho@impinj.com>
 <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
 <1509469061.5473.16.camel@impinj.com>
 <20171102151439.6dpfud7a5vtc27dy@sirena.co.uk>
 <1509731639.5473.60.camel@impinj.com>
 <20171103183700.spnqbagr4q7fth4k@sirena.co.uk>
 <1509736735.5473.87.camel@impinj.com>
 <20171103193649.jcoiy3raefikko2h@sirena.co.uk>
 <1509739759.5473.93.camel@impinj.com>
Message-ID: <20171103201150.7lt2bc6co7angy5w@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 08:09:19PM +0000, Trent Piepho wrote:
> On Fri, 2017-11-03 at 19:36 +0000, Mark Brown wrote:

> > Is there any documentation of the bindings for this driver at all?  I
> > wasn't able to find it.

> Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt

Ah, good - for some reason I'd thought that was a different IP block
(SPI controllers are like serial ports, endless room for innovation!).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171103/89aabf5a/attachment.sig>
