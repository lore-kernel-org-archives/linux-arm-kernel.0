From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 25 Aug 2014 09:05:50 +0200
Subject: [PATCH] watchdog: imx2_wdt: Remove seperate big endian handling
In-Reply-To: <4b9a55951535433aada42332b08f664f@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1408949015-28759-1-git-send-email-mpa@pengutronix.de>
 <4b9a55951535433aada42332b08f664f@BY2PR0301MB0613.namprd03.prod.outlook.com>
Message-ID: <20140825070550.GA11914@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xiubo,

On Mon, Aug 25, 2014 at 07:01:57AM +0000, Li.Xiubo at freescale.com wrote:
> Hi Markus,
> 
> Thanks for your work.
> 
> And there has already one patch for this:
> 
> "watchdog: imx2_wdt: Convert to use regmap framework's endianness method."

Thanks didn't see this one.

Best regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140825/9e17bf43/attachment.sig>
