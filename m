From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 10 Jan 2013 10:28:01 +0100
Subject: [PATCH 1/2] ARM: OMAP2+: omap2plus_defconfig: enable TFP410 chip
 support
In-Reply-To: <50D1DC95.8090003@ti.com>
References: <1355920420-20852-1-git-send-email-javier.martinez@collabora.co.uk>
 <50D1DC95.8090003@ti.com>
Message-ID: <CABxcv=nyuOJaLcHR=DgnXSxLkF-TqU2_mxt=46qZVWg_Vhh_9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 4:26 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 2012-12-19 14:33, Javier Martinez Canillas wrote:
>> Many OMAP3 based boards such as Beagle, Overo and IGEP use
>> the TFP410 DPI-to-DVI chip. So, it's good to have it built
>> as a module by default on OMAP2+ config.
>
> Also on OMAP4 boards, like Panda.
>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>  arch/arm/configs/omap2plus_defconfig |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
>> index a1dc5c0..da530a0 100644
>> --- a/arch/arm/configs/omap2plus_defconfig
>> +++ b/arch/arm/configs/omap2plus_defconfig
>> @@ -146,6 +146,7 @@ CONFIG_OMAP2_DSS_SDI=y
>>  CONFIG_OMAP2_DSS_DSI=y
>>  CONFIG_FB_OMAP2=m
>>  CONFIG_PANEL_GENERIC_DPI=m
>> +CONFIG_PANEL_TFP410=m
>>  CONFIG_PANEL_SHARP_LS037V7DW01=m
>>  CONFIG_PANEL_NEC_NL8048HL11_01B=m
>>  CONFIG_PANEL_TAAL=m
>>
>
> For both patches:
>
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>
>  Tomi
>

Hello Tony,

Any comments on these?

Thanks a lot and best regards,
Javier
