From: broonie@kernel.org (Mark Brown)
Date: Sat, 18 Apr 2015 18:16:17 +0100
Subject: [PATCH v3] spi: bitbang: only toggle bitchanges
In-Reply-To: <db1d2b9a-730b-40a5-a4f6-091fd3fad0e7@email.android.com>
References: <20150331202306.GX2869@sirena.org.uk>
 <1428922770-16955-1-git-send-email-m.grzeschik@pengutronix.de>
 <20150418120926.GL26185@sirena.org.uk>
 <db1d2b9a-730b-40a5-a4f6-091fd3fad0e7@email.android.com>
Message-ID: <20150418171617.GZ26185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 18, 2015 at 03:18:49PM +0200, Marc Kleine-Budde wrote:

> IIRC we had a reduction of about 30% when programming an FPGA via SPI.
> But Michael can give you the exact numbers. 

OK, that's definitely worth writing home about - putting that in the
commit message would have helped a lot!  I've applied the patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150418/dc5213ca/attachment.sig>
