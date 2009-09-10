From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 10 Sep 2009 08:26:09 +0200
Subject: [Uclinux-dist-devel] Removing deprecated drivers from
	drivers/i2c/chips
In-Reply-To: <8bd0f97a0909091654h290180e5ob79178583aca143f@mail.gmail.com>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
	<8bd0f97a0909091654h290180e5ob79178583aca143f@mail.gmail.com>
Message-ID: <20090910062609.GA26454@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> the Blackfin defconfigs refer to an input driver for the PCF8574, not
> the I2C client driver

Yup, I am aware of that. With the exception of:

blackfin/configs/PNAV-10_defconfig:773:CONFIG_SENSORS_PCF8574=m

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090910/8230bb17/attachment.sig>
