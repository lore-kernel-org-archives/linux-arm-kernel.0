From: acourbot@nvidia.com (Alex Courbot)
Date: Sat, 17 Nov 2012 12:18:35 +0900
Subject: [PATCH] ARM: tegra: seaboard: enable internal LCD
In-Reply-To: <1353092114-18410-1-git-send-email-swarren@wwwdotorg.org>
References: <1353092114-18410-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50A7020B.6070708@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2012 03:55 AM, Stephen Warren wrote:
> +	host1x {
> +		dc at 54200000 {
> +			rgb {
> +				status = "okay";
> +				nvidia,ddc-i2c-bus = <&lcd_ddc>;
> +				backlight = <&backlight>;

I guess the remark Thierry made on my patch that the property should be 
"nvidia,backlight" (and that it will not be supported for 3.8 anyway) 
also applies here.

Alex.
