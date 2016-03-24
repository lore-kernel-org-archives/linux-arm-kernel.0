From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 Mar 2016 09:53:32 +0000
Subject: [PATCH] ARM: dts: exynos: Fix invalid maximum voltage for buck9
 supplying SD card
In-Reply-To: <1458807125-13580-1-git-send-email-k.kozlowski@samsung.com>
References: <1458807125-13580-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160324095332.GS2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 05:12:05PM +0900, Krzysztof Kozlowski wrote:

>  			buck9_reg: BUCK9 {
>  				regulator-name = "vdd_2.8v_ldo";
>  				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3750000>;
> +				regulator-max-microvolt = <3755000>;
>  				regulator-always-on;
>  				regulator-boot-on;
>  			};

Why does this regulator even have voltage constraints configured?  Is
there any intention that it should ever be varied at runtime?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160324/eda6862e/attachment-0001.sig>
