From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Mar 2012 18:21:39 +0000
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120301182025.GC3852@pengutronix.de>
References: <1328646473-11828-1-git-send-email-festevam@gmail.com>
 <20120213082741.GN3852@pengutronix.de>
 <20120213144820.GA3494@opensource.wolfsonmicro.com>
 <20120214105823.GS3852@pengutronix.de>
 <20120214172902.GB3916@opensource.wolfsonmicro.com>
 <20120216073236.GE3852@pengutronix.de>
 <20120216075825.GA11631@opensource.wolfsonmicro.com>
 <20120301100847.GF26642@pengutronix.de>
 <20120301105239.GA3124@opensource.wolfsonmicro.com>
 <20120301182025.GC3852@pengutronix.de>
Message-ID: <20120301182139.GE10915@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2012 at 07:20:25PM +0100, Sascha Hauer wrote:
> On Thu, Mar 01, 2012 at 10:52:40AM +0000, Mark Brown wrote:

> > I've already suggested just fixing the fixed voltage regulator to be
> > more sensible when it doesn't have a voltage but you say that won't work
> > without explaining why you think that is the case and are still ignoring
> > my repeated queries about that.

> Maybe because I don't understand what you mean. What should the fixed
> regulator do when voltage == 0?

Not report that it has a voltage so report an error when asked and not
claim you can enumerate them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120301/2d078f19/attachment-0001.sig>
