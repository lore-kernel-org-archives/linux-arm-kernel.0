From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 14 Feb 2012 09:29:04 -0800
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120214105823.GS3852@pengutronix.de>
References: <1328646473-11828-1-git-send-email-festevam@gmail.com>
 <20120213082741.GN3852@pengutronix.de>
 <20120213144820.GA3494@opensource.wolfsonmicro.com>
 <20120214105823.GS3852@pengutronix.de>
Message-ID: <20120214172902.GB3916@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2012 at 11:58:23AM +0100, Sascha Hauer wrote:
> On Mon, Feb 13, 2012 at 06:48:21AM -0800, Mark Brown wrote:

> > If the board really has so few software controlled regulators then they
> > should just be using the dummy regulator support which already exists,
> > someone should just add a knob to turn it on automatically.

> I thought we agree that generally turning on the dummy regulator is a
> bad idea. Now you are advocating for the dummy regulator again.

Well, no.  I'm saying that people are being far too trigger happy with
it and that if someone wants to add a mechanism for turning it on they
need to deal with the fact that it currntly warns every time it does
anything but there are some resonable use cases, especially on very old
boards.

The main thing here is to avoid these driver specific bodges that people
keep churning out again and again, it's quite depressing really.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120214/a0696ce7/attachment.sig>
