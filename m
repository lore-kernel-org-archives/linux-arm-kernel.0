From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 30 Apr 2012 23:02:22 +0200
Subject: [PATCH 1/2] I2C: Set I2C timing registers for mxs-i2c
In-Reply-To: <201204302247.17242.marex@denx.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <201204302209.12482.marex@denx.de>
 <20120430202742.GC28226@pengutronix.de>
 <201204302247.17242.marex@denx.de>
Message-ID: <20120430210222.GF28226@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Indeed. Default to 100kHz might be a good idea too, in case user entered some 
> weird value. Eventually, it'd be nice if we could calculate the timing values 
> for all possible frequencies, but I didn't got to deriving such formula ... 
> dunno if it's worth it either, doubt so.

Would be awesome to have it; but we can leave it for later when it is
actually needed.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120430/904f919e/attachment.sig>
