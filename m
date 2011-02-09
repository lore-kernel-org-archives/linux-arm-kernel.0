From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 09 Feb 2011 23:13:26 +0300
Subject: [PATCH] ARM: imx/eukrea_mbimx27: fix compile warnings about unused
	variables
In-Reply-To: <20110209193907.GS27982@pengutronix.de>
References: <1297196241-26564-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<4D529D3E.5090405@ru.mvista.com>
	<20110209193907.GS27982@pengutronix.de>
Message-ID: <4D52F566.1070009@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Uwe Kleine-K?nig wrote:

>>> Signed-off-by: Uwe Kleine-K?nig<u.kleine-koenig@pengutronix.de>
>> [...]

>>> diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
>>> index 275c858..9ac5348 100644
>>> --- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
>>> +++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
>> [...]
>>> @@ -268,7 +268,8 @@ static struct ads7846_platform_data ads7846_config __initdata = {
>>>  	.keep_vref_on		= 1,
>>>  };
>>>
>>> -static struct spi_board_info eukrea_mbimx27_spi_board_info[] __initdata = {
>>> +static struct spi_board_info __maybe_unused
>>> +eukrea_mbimx27_spi_board_info[] __initdata = {

>>    I think the second line should be somewhat indented.

> I like it as it is.  There are no rules for that, no?

    Documentation/CodingStyle, chapter 2.

> Uwe

WBR, Sergei
