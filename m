From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Nov 2015 13:50:40 -0800
Subject: [PATCH 02/18] ARM: am57xx: cl-som-am57x: dts: add RTC support
In-Reply-To: <1448433590-1399-3-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448433590-1399-3-git-send-email-lifshitz@compulab.co.il>
Message-ID: <20151130215040.GD23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dmitry Lifshitz <lifshitz@compulab.co.il> [151124 22:41]:
> +&i2c4 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4_pins_default>;
> +	clock-frequency = <100000>;
> +
> +	rtc0: rtc at 56 {
> +		compatible = "emmicro,em3027";
> +		reg = <0x56>;
> +	};
> +};
> +
> +

Please check this series too to remove the extra lines at the end of the files
for each patch for the whitespace errors and unify the Subject to start
with "ARM: dts: ..." thanks.

Tony
