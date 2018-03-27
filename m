From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 27 Mar 2018 10:04:50 -0700
Subject: [PATCH v5 05/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
In-Reply-To: <1521800336-19266-6-git-send-email-sricharan@codeaurora.org>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-6-git-send-email-sricharan@codeaurora.org>
Message-ID: <20180327170450.GH1403@tuxbook-pro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
> +	soc {
> +		pinctrl at 1000000 {
> +			serial_0_pins: serial0_pinmux {

Please, no underscores in the node name.

> +				mux {

Fyi, you can put the pinctrl properties directly into the state node,
omitting the "mux" level.

> +					pins = "gpio16", "gpio17";
> +					function = "blsp_uart0";
> +					bias-disable;
> +				};
> +			};
> +

Apart from this the patch looks good.

Regards,
Bjorn
