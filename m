From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 6 Sep 2018 14:53:00 +0200
Subject: [PATCH v2] arm64: dts: add support for SolidRun Clearfog GT 8K
In-Reply-To: <a8f5114101ac62622a8b8152ba5415f39e52f05b.1536232787.git.baruch@tkos.co.il>
References: <a8f5114101ac62622a8b8152ba5415f39e52f05b.1536232787.git.baruch@tkos.co.il>
Message-ID: <20180906125300.GA22121@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> v2:
>   * Add SATA node
> 
>   * Set front button code to KEY_WPS_BUTTON
> 
>   * Use LEDs labels more aligned to conversion

Hi Baruch

It would be good to say why you did not make it fully aligned to
convention. What is wrong with "clearfog-gt-8k:green:led0"

> +		mdio {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			switch0phy0: switch0phy0 at 11 {
> +				reg = <0x11>;
> +			};
> +			switch0phy1: switch0phy1 at 12 {
> +				reg = <0x12>;
> +			};
> +			switch0phy2: switch0phy2 at 13 {
> +				reg = <0x13>;
> +			};
> +			switch0phy3: switch0phy3 at 14 {
> +				reg = <0x14>;
> +			};
> +		};

It would be nice to add a black line after each child node.

Otherwise, this looks good.

	   Andrew
