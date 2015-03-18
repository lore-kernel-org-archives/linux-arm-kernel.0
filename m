From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 18 Mar 2015 12:26:43 +0000
Subject: [PATCH 1/2] DT: arm64: msm8916: add all SPI DT nodes
In-Reply-To: <1426609532-11996-1-git-send-email-stanimir.varbanov@linaro.org>
References: <1426609532-11996-1-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <55096F03.9060101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/03/15 16:25, Stanimir Varbanov wrote:
> +
> +			spi4_sleep: spi4_sleep {
> +				pinmux {
> +					function = "gpio";
> +					pins = "gpio12", "gpio13", "gpio14", "gpio15";
> +	
....

> +
> +			spi5_sleep: spi4_sleep {
Will result in Duplicate node name error for "spi4_sleep"

> +				pinmux {
> +					function = "gpio";
> +					pins = "gpio16", "gpio17", "gpio18", "gpio19";
> +				};
> +				pinconf {
> +					pins = "gpio16", "gpio17", "gpio18", "gpio19";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +			};
