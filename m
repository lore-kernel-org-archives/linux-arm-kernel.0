From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Feb 2015 10:51:34 +0000
Subject: [PATCH 09/13] ARM: dts: mediatek: Enable clock support for
 Mediatek MT8135.
In-Reply-To: <1423478845-2835-10-git-send-email-s.hauer@pengutronix.de>
References: <1423478845-2835-1-git-send-email-s.hauer@pengutronix.de>
 <1423478845-2835-10-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150209105134.GF8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 09, 2015 at 11:47:21AM +0100, Sascha Hauer wrote:
> From: James Liao <jamesjj.liao@mediatek.com>
> 
> This patch adds MT8135 clock controllers into device tree.
> @@ -86,6 +87,18 @@
>  			clock-frequency = <32000>;
>  			#clock-cells = <0>;
>  		};
> +
> +		clk_null: clk_null {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <0>;
> +		};
> +
> +		clk26m: clk26m {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <26000000>;
> +		};

Is this supposed to be here?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
