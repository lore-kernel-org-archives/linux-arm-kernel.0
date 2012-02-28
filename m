From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 28 Feb 2012 10:52:22 +0000
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120228082715.GK3852@pengutronix.de>
References: <20120213144820.GA3494@opensource.wolfsonmicro.com>
 <20120214105823.GS3852@pengutronix.de>
 <20120214172902.GB3916@opensource.wolfsonmicro.com>
 <20120216073236.GE3852@pengutronix.de>
 <20120216075825.GA11631@opensource.wolfsonmicro.com>
 <20120227090453.GE26642@pengutronix.de>
 <20120227132908.GA3191@opensource.wolfsonmicro.com>
 <20120227172020.GC3852@pengutronix.de>
 <20120227235359.GA23230@opensource.wolfsonmicro.com>
 <20120228082715.GK3852@pengutronix.de>
Message-ID: <20120228105222.GB3683@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 09:27:15AM +0100, Sascha Hauer wrote:
> On Mon, Feb 27, 2012 at 11:54:00PM +0000, Mark Brown wrote:

> > No, zero is intentionally a valid response - it means that the selector
> > is invalid (for example, due to being documented as a reserved value)
> > allowing a non-error return that doesn't provide a voltage.  The fixed
> > regulator should be fixed to return an error if it hasn't got a voltage
> > configured.

> Hm, you asked me to drop the voltage parameter from the helper function
> registering a fixed regulator as dummy. When the fixed regulator bails
> out in this case I can't see how this can be done.

Can you be more specific about what you think would break here please?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120228/7a5d4350/attachment.sig>
