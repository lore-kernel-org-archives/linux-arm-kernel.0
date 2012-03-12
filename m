From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 12 Mar 2012 20:16:50 +0100
Subject: [PATCH v7 4/4] USB: ohci-nxp: Remove i2c_write(), use smbus
In-Reply-To: <1331463219-23293-5-git-send-email-stigge@antcom.de>
References: <1331463219-23293-1-git-send-email-stigge@antcom.de>
 <1331463219-23293-5-git-send-email-stigge@antcom.de>
Message-ID: <20120312191650.GB28087@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +	i2c_smbus_write_byte_data(isp1301_i2c_client,
> +		ISP1301_I2C_INTERRUPT_RISING | ISP1301_I2C_REG_CLEAR_ADDR,
> +		0xFF);

No need to resend, still: Breaking the 80 char limit for such cases is usually
more readable.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120312/7ace2dde/attachment.sig>
