From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 16 Oct 2013 16:01:13 +0200
Subject: [PATCH] MAINTAINERS: Add patterns for DTS files for AT91
In-Reply-To: <1381921447-21811-1-git-send-email-broonie@kernel.org>
References: <1381921447-21811-1-git-send-email-broonie@kernel.org>
Message-ID: <525E9C29.7010301@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/10/2013 13:04, Mark Brown :
> From: Mark Brown <broonie@linaro.org>
>
> Help ensure updates to the DTS files for AT91 machines and devices get
> sent to the maintainers by adding patterns to the MAINTAINERS entry for
> the architecture.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d5714d0..c610fb8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -777,6 +777,8 @@ W:	http://maxim.org.za/at91_26.html
>   W:	http://www.linux4sam.org
>   S:	Supported
>   F:	arch/arm/mach-at91/
> +F:	arch/arm/boot/dts/at91*.dts
> +F:	arch/arm/boot/dts/at91*.dtsi

Unfortunately, we added some more strings for our new C-A5 product 
family. I tried to be more generic possible without messing with other 
product names. So what about adding these lines?

+F:	arch/arm/boot/dts/sama*.dts
+F:	arch/arm/boot/dts/sama*.dtsi

If it is okay with you, I can add them directly in your patch when 
taking it in my tree, do not bother.


>   ARM/CALXEDA HIGHBANK ARCHITECTURE
>   M:	Rob Herring <rob.herring@calxeda.com>

Thanks, bye,
-- 
Nicolas Ferre
