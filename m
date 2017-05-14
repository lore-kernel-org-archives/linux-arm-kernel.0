From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Sat, 13 May 2017 20:31:08 -0700
Subject: [PATCH 1/2 v6] ARM: dts: add XOADC and IIO HWMON to
 MSM8660/APQ8060
In-Reply-To: <20170513141543.24759-1-linus.walleij@linaro.org>
References: <20170513141543.24759-1-linus.walleij@linaro.org>
Message-ID: <20170514033108.GB69278@Bjorns-MacBook-Pro-2.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 13 May 07:15 PDT 2017, Linus Walleij wrote:

> +				xoadc: xoadc at 197 {
> +					compatible = "qcom,pm8058-adc";
> +					reg = <0x197>;
> +					interrupts-extended = <&pm8058 76 IRQ_TYPE_EDGE_RISING>;
> +					#address-cells = <2>;
> +					#size-cells = <0>;
> +					#io-channel-cells = <2>;
> +
> +					vcoin: adc-channel at 00 {

Is it possible to reference these nodes directly? Regardless they make
the dts human readable, so I'm fine either way.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
