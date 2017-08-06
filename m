From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 06 Aug 2017 12:38:36 +0200
Subject: [PATCH v2] ARM: dts: rockchip: rk322x: add spi node and spi
 pinctrl
In-Reply-To: <1501727810-31761-1-git-send-email-huibin.hong@rock-chips.com>
References: <1501727810-31761-1-git-send-email-huibin.hong@rock-chips.com>
Message-ID: <2042865.sKzShaQPbs@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Donnerstag, 3. August 2017, 10:36:49 CEST schrieb Huibin Hong:
> Add spi node and spi pinctrl for rk322x
> 
> Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>

[...]


> +	};
> +
>  	wdt: watchdog at 110a0000 {
>  		compatible = "rockchip,rk322x-wdt", "snps,dw-wdt";

Please make sure a patch actually applies against the mainline tree,
as here the the compatible for the watchdog looks slightly different.

In any case I've fixed that and applied it for 4.14


Heiko
