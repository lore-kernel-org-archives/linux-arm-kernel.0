From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 21 Dec 2009 16:33:38 +0100
Subject: [PATCH 1/2] imx/mx3: fix FTBFS for undefined symbols
	mx31_usbh1 and mx31_usbh2
In-Reply-To: <4B2F8D50.60902@epfl.ch>
References: <1261253921-29125-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<4B2F8D50.60902@epfl.ch>
Message-ID: <20091221153338.GB31014@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2009 at 03:59:28PM +0100, Valentin Longchamp wrote:
> Hallo Uwe,
>
> Uwe Kleine-K?nig wrote:
>> Use the symbols mxc_usbh1 and mxc_usbh2 introduced in
>>
>> 	c13a482 (MX3: Add USB platform devices and resources)
>>
>> instead.
>
> I have sent a patch to fix this. It was first sent on December, 4th and  
> again on December, 18th  
> (http://article.gmane.org/gmane.linux.ports.arm.kernel/71126)
OK, actually the patches are identically.  Sascha, you can interpret
this as an Acked-by: me.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
