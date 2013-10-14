From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 14 Oct 2013 09:38:59 +0200
Subject: [PATCH 0/5] ARM:at91:enable sound on at91sam9n12ek board
In-Reply-To: <1381729113-29714-1-git-send-email-voice.shen@atmel.com>
References: <1381729113-29714-1-git-send-email-voice.shen@atmel.com>
Message-ID: <525B9F93.9040001@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/2013 07:38, Bo Shen :
> This patch series enable sound on at91sam9n12ek board with wm8904 codec
>
>
> Bo Shen (5):
>    ARM: at91: add at91sam9n12 ssc clock in look up table
>    ARM: at91: add ssc dma parameter for at91sam9n12
>    ARM: at91: enable wm8904 on at91sam9n12ek board
>    ARM: at91: enable ssc on at91sam9n12ek board
>    ARM: at91: add sound support on at91sam9n12ek board

Great!

And on the whole patch series:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I stack it on at91-3.13-dt branch.

Thanks.

>
>   arch/arm/boot/dts/at91sam9n12.dtsi  |    3 +++
>   arch/arm/boot/dts/at91sam9n12ek.dts |   34 ++++++++++++++++++++++++++++++++++
>   arch/arm/mach-at91/at91sam9n12.c    |    1 +
>   3 files changed, 38 insertions(+)
>


-- 
Nicolas Ferre
