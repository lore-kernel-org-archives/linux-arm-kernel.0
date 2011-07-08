From: b32955@freescale.com (Huang Shijie)
Date: Fri, 8 Jul 2011 15:01:13 +0800
Subject: [PATCH v6 1/4] ARM: mxs: add GPMI-NAND support for imx23/imx28
In-Reply-To: <20110708065337.GN29624@pengutronix.de>
References: <1310102885-4102-1-git-send-email-b32955@freescale.com>
	<1310102885-4102-2-git-send-email-b32955@freescale.com>
	<20110708065337.GN29624@pengutronix.de>
Message-ID: <4E16AB39.5000405@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:
> Hello Huang,
>
> On Fri, Jul 08, 2011 at 01:28:02PM +0800, Huang Shijie wrote:
>> +/* The size of the resource is fixed. */
>> +#define RES_SIZE	6
> This name is too generic. Maybe GPMI_NAND_RES_SIZE?
ok.  I will change it in later version.

  thanks.

Best Regards
Huang Shijie
> Best regards
> Uwe
>
