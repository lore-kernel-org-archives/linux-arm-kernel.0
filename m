From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 29 Apr 2015 12:24:59 +0200
Subject: [PATCH v2] MAINTAINERS: replace an AT91 maintainer
In-Reply-To: <1430301438-11839-1-git-send-email-nicolas.ferre@atmel.com>
References: <1430293252-9167-1-git-send-email-nicolas.ferre@atmel.com>
 <1430301438-11839-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150429102459.GA3242@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/04/2015 at 11:57:18 +0200, Nicolas Ferre wrote :
> As some help is needed from an active maintainer, replace Andrew Victor
> by Alexandre Belloni in the ARM/Atmel MAINTAINERS' entry (aka AT91).
> Add an entry to the CREDITS file.
> 
> Thanks Andrew for the great role you played during the early days of this
> product family.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Andrew Victor <linux@maxim.org.za>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
> Changes for v2:
> - add the CREDITS enty
> 
>  CREDITS     | 7 +++++++
>  MAINTAINERS | 3 +--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/CREDITS b/CREDITS
> index 40cc4bfb34db..ec7e6c7fdd1b 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -3709,6 +3709,13 @@ N: Dirk Verworner
>  D: Co-author of German book ``Linux-Kernel-Programmierung''
>  D: Co-founder of Berlin Linux User Group
>  
> +N: Andrew Victor
> +E: linux at maxim.org.za
> +W: http://maxim.org.za/at91_26.html
> +D: First maintainer of Atmel ARM-based SoC, aka AT91
> +D: Introduced support for at91rm9200, the first chip of AT91 family
> +S: South Africa
> +
>  N: Riku Voipio
>  E: riku.voipio at iki.fi
>  D: Author of PCA9532 LED and Fintek f75375s hwmon driver
> diff --git a/MAINTAINERS b/MAINTAINERS
> index be26fc584cc6..1512e958082a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -892,11 +892,10 @@ S:	Maintained
>  F:	arch/arm/mach-alpine/
>  
>  ARM/ATMEL AT91RM9200 AND AT91SAM ARM ARCHITECTURES
> -M:	Andrew Victor <linux@maxim.org.za>
>  M:	Nicolas Ferre <nicolas.ferre@atmel.com>
> +M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
>  M:	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> -W:	http://maxim.org.za/at91_26.html
>  W:	http://www.linux4sam.org
>  S:	Supported
>  F:	arch/arm/mach-at91/
> -- 
> 2.1.3
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
