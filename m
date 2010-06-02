From: jason77.wang@gmail.com (jason wang)
Date: Wed, 2 Jun 2010 22:29:48 +0800
Subject: [PATCH 3/3] mx51/clock: add keypad clock definition and
	registration
References: <1275405043-18230-1-git-send-email-jason77.wang@gmail.com>
	<1275405043-18230-2-git-send-email-jason77.wang@gmail.com>
	<1275405043-18230-3-git-send-email-jason77.wang@gmail.com>
	<1275405043-18230-4-git-send-email-jason77.wang@gmail.com>
	<20100602080054.GL2346@matterhorn.lan>
Message-ID: <003c01cb0260$162f36a0$9b00a8c0@wuef10f27ebed8>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<snip>

>>  _REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
>> + _REGISTER_CLOCK(NULL, "kpp", kpp_clk)
> 
> Should be
> 
> _REGISTER_CLOCK("imx-keypad", NULL, kpp_clk)
> 
> since that is the device id that will be used in your platform device.
>
Accept, will be fixed in V2.

Thanks,
Jason. 
> -- 
> ----------------------------------------------------------------------
> Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
> ----------------------------------------------------------------------
