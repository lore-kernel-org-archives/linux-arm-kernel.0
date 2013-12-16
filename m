From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Dec 2013 23:23:31 +0000
Subject: [PATCHv4] rtc: Add support for Intersil ISL12057 I2C RTC chip
In-Reply-To: <20131216213706.GA8527@roeck-us.net>
References: <1dec5992db795b61e91e0abf910dee7fce322ccc.1387227955.git.arno@natisbad.org>
 <20131216213706.GA8527@roeck-us.net>
Message-ID: <20131216232331.GK3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 01:37:06PM -0800, Guenter Roeck wrote:

> Here is a snippet from the saved patch:

>  obj-$(CONFIG_RTC_DRV_IMXDI)    +=3D rtc-imxdi.o
>  obj-$(CONFIG_RTC_DRV_ISL1208)  +=3D rtc-isl1208.o
>  obj-$(CONFIG_RTC_DRV_ISL12022) +=3D rtc-isl12022.o
> +obj-$(CONFIG_RTC_DRV_ISL12057)  +=3D rtc-isl12057.o
>  obj-$(CONFIG_RTC_DRV_JZ4740)   +=3D rtc-jz4740.o
>  obj-$(CONFIG_RTC_DRV_LP8788)   +=3D rtc-lp8788.o
>  obj-$(CONFIG_RTC_DRV_LPC32XX)  +=3D rtc-lpc32xx.o

> Something is adding those '3D' after each '=' into the patch.

That's quoted printable MIME encoding of the =, presumably your MUA
doesn't do MIME (or the header went AWOL, though it's there in my copy).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/1da3c983/attachment.sig>
