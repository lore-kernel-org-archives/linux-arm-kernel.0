From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 6 Oct 2013 15:54:53 +0200
Subject: [PATCH 1/3 V2] i2c: mxs: distinguish i.MX23 and i.MX28 based I2C
 controller
In-Reply-To: <1380497035-7457-1-git-send-email-marex@denx.de>
References: <1380497035-7457-1-git-send-email-marex@denx.de>
Message-ID: <20131006135453.GC4173@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 01:23:53AM +0200, Marek Vasut wrote:
> From: Juergen Beisert <jbe@pengutronix.de>
> 
> It seems the PIO mode does not work, or at least not like it works
> on a i.MX28. Each short transfer needs about one second (without an
> error message) but does not send anything on the I2C lines.
> 
> From: Juergen Beisert <jbe@pengutronix.de>
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Christoph Baumann <cb@sgoc.de>
> Cc: Fabio Estevam <r49496@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Torsten Fleischer <to-fleischer@t-online.de>
> Cc: Wolfram Sang <wsa@the-dreams.de>

This lacked your SoB. To ease things, I added it here. Please shout if
you don't like me adding it...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131006/6e578fd9/attachment-0001.sig>
