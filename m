From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 21 Aug 2013 11:35:40 +0200
Subject: [PATCH v2 0/3] arm: atmel: at91sam9n12: add i2c pinctrl and qt1070
 support
In-Reply-To: <1373513446-18215-1-git-send-email-voice.shen@atmel.com>
References: <1373513446-18215-1-git-send-email-voice.shen@atmel.com>
Message-ID: <521489EC.9090107@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2013 05:30, Bo Shen :
> this patch is based on linux master branch, implementation as following:
>    - add the i2c pinctrl which needed for using at91sam9n12 TWI
>    - enable qt1070
>    - trival fix for the gpio-key pin number

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

On the whole series.

>
> Changes in v2:
>    - remove comments as use micro
>    - using micro for interrupt trigger mode
>
> Bo Shen (3):
>    arm: atmel: at91sam9n12: add pinctrl of TWI

Beware:
1/ "arm" in upper case
2/ not "atmel" as second identifier but "at91" (lower case)

>    arm: atmel: at91sam9n12: add qt1070 support
>    arm: atmel: at91sam9n12: correct pin number of gpio-key
>
>   arch/arm/boot/dts/at91sam9n12.dtsi  |   20 ++++++++++++++++++++
>   arch/arm/boot/dts/at91sam9n12ek.dts |   18 +++++++++++++++++-
>   2 files changed, 37 insertions(+), 1 deletion(-)
>


-- 
Nicolas Ferre
