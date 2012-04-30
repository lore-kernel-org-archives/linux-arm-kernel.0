From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 30 Apr 2012 07:58:25 +0200
Subject: [PATCH 1/2] I2C: Set I2C timing registers for mxs-i2c
In-Reply-To: <1335738969-27445-1-git-send-email-marex@denx.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
Message-ID: <20120430055825.GA7926@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2012 at 12:36:08AM +0200, Marek Vasut wrote:
> This sets the bus to run at 400kHz, prior to this,
> the bus frequency was undefined.

Not exactly. The default values let it run at 100kHz. Since not all
slaves support 400kHz, I have to NACK this one. Making it configurable
is the way to go here.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120430/ce7d39c1/attachment.sig>
