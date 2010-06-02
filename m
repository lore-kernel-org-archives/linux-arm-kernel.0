From: jason77.wang@gmail.com (jason wang)
Date: Wed, 2 Jun 2010 22:28:37 +0800
Subject: [PATCH 3/3] mx51/clock: add keypad clock definition
	andregistration
References: <1275405043-18230-1-git-send-email-jason77.wang@gmail.com>
	<1275405043-18230-2-git-send-email-jason77.wang@gmail.com>
	<1275405043-18230-3-git-send-email-jason77.wang@gmail.com>
	<1275405043-18230-4-git-send-email-jason77.wang@gmail.com>
	<20100602074358.GL26820@pengutronix.de>
Message-ID: <003601cb025f$ee6cfda0$9b00a8c0@wuef10f27ebed8>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<snip>
>>  _REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", ahb_clk)
>>  _REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
>>  _REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
>> + _REGISTER_CLOCK(NULL, "kpp", kpp_clk)
> 
> _REGISTER_CLOCK("imx-keypad", NULL, kpp_clk)
> 
> (or imx-keypad.0 depending on what id the kpp platform_device has)
> 
Accept, will be addressed in V2.

Thanks,
Jason.
> SAscha
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
