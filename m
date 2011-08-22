From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 22 Aug 2011 13:30:54 +0200
Subject: [PATCH 1/2] ASoC: mxs-saif: add record function
In-Reply-To: <1313942545-21403-1-git-send-email-b29396@freescale.com>
References: <1313942545-21403-1-git-send-email-b29396@freescale.com>
Message-ID: <20110822113054.GC2006@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2011 at 12:02:25AM +0800, Dong Aisheng wrote:
> 1. add different clkmux mode handling for record.
> SAIF can use two instances to implement full duplex (playback &
> recording) and record saif may work on EXTMASTER mode that is
> using other saif's BITCLK&LRCLK.
> The clkmux mode is determined by saif's platform data and machine
> specific clkmux setting is done in pdata->init().
> 2. support playback and capture simutaneously however the sample
> rates can not be different due to hw limitation.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Wolfram Sang <w.sang@pengutronix.de>

Will test and review, but probably not before Wednesday.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110822/b76e2d0c/attachment.sig>
