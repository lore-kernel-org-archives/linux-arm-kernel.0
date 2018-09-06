From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Sep 2018 11:15:17 +0100
Subject: [PATCH v9 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20180827014815.GD29208@dragon>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
 <20180802104443.GH9117@sirena.org.uk>
 <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
 <20180802113552.GJ9117@sirena.org.uk>
 <20180827014815.GD29208@dragon>
Message-ID: <20180906101516.GA5360@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 09:48:16AM +0800, Shawn Guo wrote:

> Can you ACK on those two regulator patches, so that I can queue this
> series up on IMX tree?

I was expecting to get a pull request with the precursor patches in it -
the regulator driver seems to get a moderate amount of development so
there's a reasonable risk of conflicts.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180906/467ef2ed/attachment.sig>
