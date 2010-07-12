From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 12 Jul 2010 16:28:47 +0300
Subject: [PATCH v2 0/3] s3c24xx: iPAQ rx1950 series
In-Reply-To: <1278781069-30521-1-git-send-email-anarsoul@gmail.com>
References: <1278781069-30521-1-git-send-email-anarsoul@gmail.com>
Message-ID: <201007121628.58271.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 10 ???? 2010 19:57:46 ????? Vasily Khoruzhick ???????:
> This patch series adds more support for iPAQ rx1950 PDA to linux:
> 1. LEDs driver -- it controls blue, green and red LEDs on rx1950
> 2. Battery driver -- adds ability to monitor and charge battery.
> This driver is suitable for H1940 PDA aswell (just need to write
> some machine specific callbacks and get voltage LUTs)
> 
> v2: removed ac registration from s3c_adc_battery driver, use
> pda_power instead for ac support.
> 
> P.S. I prefer to keep own LED triggers for s3c_adc_battery as
> generic power supply triggers do not support LED_HALF brightness
> (on h1940/rx1950 it's used for blink) and I want to keep same
> LEDs behavior as in WinMo.

Ping :)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100712/722bcf65/attachment.sig>
