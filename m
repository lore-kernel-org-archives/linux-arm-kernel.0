From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 2 Jun 2012 08:48:39 +0200
Subject: [PATCH 1/2] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <201205290846.53960.marex@denx.de>
References: <1338084656-11961-1-git-send-email-marex@denx.de>
 <4FC359BC.8080606@codethink.co.uk>
 <201205290846.53960.marex@denx.de>
Message-ID: <20120602064839.GA13441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Is there not a standard speed setting in the i2c binding?
> 
> Not that I know of, but if someone hinted one to me, I'd gladly rework the 
> patches :)

It is "clock-frequency". Check 'Documentation/devicetree/bindings/i2c'.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120602/b19a34e9/attachment.sig>
