From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 9 Jul 2015 22:09:13 +0200
Subject: [PATCH] i2c: removed work arounds in i2c driver for Zynq
 Ultrascale+ MPSoC
In-Reply-To: <1434644382-11905-1-git-send-email-anuragku@xilinx.com>
References: <1434644382-11905-1-git-send-email-anuragku@xilinx.com>
Message-ID: <20150709200913.GL4744@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

thanks for the submission!

> +#define CDNS_I2C_BROKEN_HOLD_BIT	0x00000001

BIT(0) maybe?

> +static const struct cdns_platform_data r1p10_i2c_def = {
> +				.quirks = CDNS_I2C_BROKEN_HOLD_BIT, };

Closing '}' should be on seperate line.

And what Mark said.

Other than that, looks okay I'd say.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150709/9cf0edea/attachment.sig>
