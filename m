From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Dec 2012 18:54:39 +0100
Subject: [PATCH 2/3] ARM: AT91: IIO: add sleep mode support
In-Reply-To: <1355942232-26251-2-git-send-email-plagnioj@jcrosoft.com>
References: <20121219183236.GP23971@game.jcrosoft.org>
 <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com>
 <1355942232-26251-2-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <50DC8B5F.3030404@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 19/12/2012 19:37, Jean-Christophe PLAGNIOL-VILLARD a ?crit :
> The sleep mode will allow to put the add in sleep between conversion.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: linux-iio at vger.kernel.org
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-adc.txt |    1 +
>  drivers/iio/adc/at91_adc.c                          |   19 ++++++++++---------
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> index fd2d69e..efb6f02 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> @@ -25,6 +25,7 @@ Optional properties:
>    - atmel,adc-use-res: String corresponding to an identifier from
>  		       atmel,adc-res-names property. If not specified, the highest
>  		       resolution will be used.
> +  - atmel,atmel,adc-sleep-mode: Boolean to enable of sleep mode when no conversion

I forgot it in my first review, but there's a typo in the name of the
property here (one extra "atmel,")

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
