From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 15:15:08 +0100
Subject: [PATCH 0/4] ARM: at91: sama5d4ek: enable audio support
In-Reply-To: <1422859907-14881-1-git-send-email-voice.shen@atmel.com>
References: <1422859907-14881-1-git-send-email-voice.shen@atmel.com>
Message-ID: <54F7136C.5040307@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/02/2015 07:51, Bo Shen a ?crit :
> This patch set enable audio support on sama5d4ek.
> It depends the patch [1] (ASoC: atmel-pcm-dma: won't check direction
> when configure dma)
> [1] https://patchwork.kernel.org/patch/5759441/
> 
> 
> Bo Shen (4):
>   ARM: at91: dt: sama5d4: add ssc nodes
>   ARM: at91: dt: sama5d4ek: enable ssc0
>   ARM: at91: dt: sama5d4ek: add and enable wm8904
>   ARM: at91: dt: sama5d4ek: enable audio

Whole series stacked on top of at91-4.1-dt.

Thanks, bye.


>  arch/arm/boot/dts/at91-sama5d4ek.dts | 31 ++++++++++++++++
>  arch/arm/boot/dts/sama5d4.dtsi       | 70 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 101 insertions(+)
> 


-- 
Nicolas Ferre
