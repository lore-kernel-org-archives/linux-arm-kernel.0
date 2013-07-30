From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 30 Jul 2013 13:54:04 +0200
Subject: [PATCH 01/22] ARM: ux500: Remove '0x's from HREF v60+ DTS file
In-Reply-To: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
References: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20130730115403.GA29992@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2013-07-19 14:58:32, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Why?

									Pavel

> diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
> index 3d580d6..46fd8af 100644
> --- a/arch/arm/boot/dts/hrefv60plus.dts
> +++ b/arch/arm/boot/dts/hrefv60plus.dts
> @@ -26,7 +26,7 @@
>  
>  	soc {
>  		i2c at 80110000 {
> -			bu21013_tp at 0x5c {
> +			bu21013_tp at 5c {
>  				reset-gpio = <&gpio4 15 0x4>;
>  			};
>  		};

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
