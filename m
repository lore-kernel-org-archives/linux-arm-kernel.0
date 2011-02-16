From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 16 Feb 2011 10:26:57 -0200
Subject: [PATCH 16/17] mc13xxx: mfd_cell is now implicitly available to
	drivers
In-Reply-To: <20110216094154.GV13279@pengutronix.de>
References: <20110211181921.3d561568@queued.net>
	<20110216094154.GV13279@pengutronix.de>
Message-ID: <4D5BC291.1010906@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 2/16/2011 7:41 AM, Uwe Kleine-K?nig wrote:
...
>>  
>>  /* MC13783 */
>> -static struct mc13783_platform_data mc13783_pdata __initdata = {
> isn't using __initdata here broken already before your patch?  Was
> introduced in c67a3e09.  Fabio?

I followed the same approach as in the mx31_3ds.c file.

> But in general I'd prefer to keep as much __initdata as possible because
> this occupies less memory when using a multi-machine kernel.

So keeping __initdata is OK then? Let me know and I can fix it needed.

Regards,

Fabio Estevam
