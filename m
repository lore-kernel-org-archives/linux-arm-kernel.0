From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 11 Apr 2014 09:18:03 -0300
Subject: [PATCH] ARM: dts: imx6sl-evk: Add an entry for
 MX6SL_PAD_ECSPI1_SS0__GPIO4_IO11
In-Reply-To: <201404111415.52225.marex@denx.de>
References: <1397218179-3533-1-git-send-email-festevam@gmail.com>
 <201404111415.52225.marex@denx.de>
Message-ID: <CAOMZO5D9MefK0f05vtok2AfLuBCQs9_Eb+wkRdsBF0qPH6=KYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 9:15 AM, Marek Vasut <marex@denx.de> wrote:

>> diff --git a/arch/arm/boot/dts/imx6sl-evk.dts
>> b/arch/arm/boot/dts/imx6sl-evk.dts index 864d8df..a8d9a93 100644
>> --- a/arch/arm/boot/dts/imx6sl-evk.dts
>> +++ b/arch/arm/boot/dts/imx6sl-evk.dts
>> @@ -282,6 +282,7 @@
>>                               MX6SL_PAD_ECSPI1_MISO__ECSPI1_MISO      0x100b1
>>                               MX6SL_PAD_ECSPI1_MOSI__ECSPI1_MOSI      0x100b1
>>                               MX6SL_PAD_ECSPI1_SCLK__ECSPI1_SCLK      0x100b1
>> +                             MX6SL_PAD_ECSPI1_SS0__GPIO4_IO11
> 0x80000000
>
> Doesn't 0x80000000 mean "do not configure this pin, leave it as it was
> configured before" ?

For the PAD settings, yes, but here I am interested in setting the ALT
mode to GPIO.

It is OK to leave the PAD settings as is for the GPIO.

Regards,

Fabio Estevam
