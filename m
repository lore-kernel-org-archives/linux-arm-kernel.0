From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 18 Jun 2015 17:45:37 +0200
Subject: [PATCH v2 1/2] ARM: at91: dts: add isi & ov2640 dt nodes for
 at91sam9m10g45ek board
In-Reply-To: <1434449315-9243-1-git-send-email-josh.wu@atmel.com>
References: <1434449315-9243-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20150618154537.GM27492@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Seems good to me, a small comment below:

On 16/06/2015 at 18:08:34 +0800, Josh Wu wrote :
> @@ -1068,8 +1076,12 @@
>  				clocks = <&isi_clk>;
>  				clock-names = "isi_clk";
>  				pinctrl-names = "default";
> -				pinctrl-0 = <&pinctrl_isi>;
> +				pinctrl-0 = <&pinctrl_isi_data_0_7>;

I would say that the pinctrl is board specific so both pinctrl-names and
pinctrl-0 should go to at91sam9m10g45ek.dts

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
