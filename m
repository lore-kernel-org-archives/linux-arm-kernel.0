From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 24 May 2010 22:34:28 +0200
Subject: [PATCH 09/16] arm/mx2/mbimx27: compile fixes with
	CONFIG_TOUCHSCREEN_ADS7846=y
In-Reply-To: <4BFADD4F.80309@eukrea.com>
References: <20100524195430.GA28403@pengutronix.de>
	<1274730951-29106-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<4BFADD4F.80309@eukrea.com>
Message-ID: <20100524203428.GB29092@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Mon, May 24, 2010 at 10:10:55PM +0200, Eric B?nard wrote:
> Hi Uwe,
>
> Le 24/05/2010 21:55, Uwe Kleine-K?nig a ?crit :
>> This fixes:
>>
>> 	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:166: error: expected identifier or '(' before '||' token
>> 	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:204: error: variable 'eukrea_mbimx27_spi_0_data' has initializer but incomplete type
>> 	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:205: error: unknown field 'chipselect' specified in initializer
>> 	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:205: warning: excess elements in struct initializer
>> 	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:205: warning: (near initialization for 'eukrea_mbimx27_spi_0_data')
>> 	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:206: error: unknown field 'num_chipselect' specified in initializer
>> 	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:206: warning: excess elements in struct initializer
>> 	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:206: warning: (near initialization for 'eukrea_mbimx27_spi_0_data')
>> 	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c: In function 'eukrea_mbimx27_baseboard_init':
>> 	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:239: error: implicit declaration of function 'ads7846_dev_init'
>>
>> While at it add TOUCHSCREEN_ADS7846=m to mx27_defconfig.
>>
> I already fixed this in my patchset for this board :
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/015826.html

What do you think about adding TOUCHSCREEN_ADS7846=m to mx27_defconfig?

Other than that I'm OK with your patch, too.  I will remove this patch
from my queue.

Best regards and thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
