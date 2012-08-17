From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 17 Aug 2012 23:27:38 +0100
Subject: [alsa-devel] Lockups reading from i.MX51 SSI registers
In-Reply-To: <CAOMZO5DAs=jm-08tWdfdLG_nm=gdi-Q_RReiUKGM_RCgB82dwA@mail.gmail.com>
References: <20120810195005.GP24328@opensource.wolfsonmicro.com>
 <20120810195638.GF1451@pengutronix.de>
 <20120810201456.GL25520@pengutronix.de>
 <20120810210647.GG1451@pengutronix.de>
 <CAOMZO5DAs=jm-08tWdfdLG_nm=gdi-Q_RReiUKGM_RCgB82dwA@mail.gmail.com>
Message-ID: <20120817222738.GH18871@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2012 at 04:08:47PM -0300, Fabio Estevam wrote:

> Also, for the playback to work you need to install the SDMA firmware.

This is deadlocking during boot, I'm getting nowhere near trying
playback.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120817/4714a7a7/attachment.sig>
