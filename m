From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 13 Feb 2012 06:48:21 -0800
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120213082741.GN3852@pengutronix.de>
References: <1328646473-11828-1-git-send-email-festevam@gmail.com>
 <20120213082741.GN3852@pengutronix.de>
Message-ID: <20120213144820.GA3494@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 09:27:41AM +0100, Sascha Hauer wrote:

> I really don't want to have that much code for saying 'we don't have a
> regulator, just make this stupid driver happy'. This is fine for one
> board, but not for the more than a dozen users of this driver in the tree.
> We should really add a helper to simplify this.

If the board really has so few software controlled regulators then they
should just be using the dummy regulator support which already exists,
someone should just add a knob to turn it on automatically.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120213/299be1a2/attachment-0001.sig>
