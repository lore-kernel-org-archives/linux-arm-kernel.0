From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 13 Sep 2015 18:59:44 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: Add dtb for the Radxa Rock 2
 Square board
In-Reply-To: <1442011005-4828-2-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1442011005-4828-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1442011005-4828-2-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1898861.3c2qccBTle@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sjoerd,

Am Samstag, 12. September 2015, 00:36:45 schrieb Sjoerd Simons:

one thing I forgot:

> +&emmc {
> +	broken-cd;
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	disable-wp;
> +	non-removable;
> +	num-slots = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
> +	vmmc-supply = <&vcc_io>;
> +	status = "okay";
> +};

this could probably use a mmc powersequence to handle the emmc-reset pin?


Heiko
