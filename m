From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 21 Nov 2014 21:34:36 +0100
Subject: [PATCHv5 09/10] arm: mvebu: add .dts file for Synology DS213j
In-Reply-To: <36a07bdc70a826e26867eba4755be82e39b35450.1416598537.git.arno@natisbad.org>
References: <cover.1416598536.git.arno@natisbad.org>
 <36a07bdc70a826e26867eba4755be82e39b35450.1416598537.git.arno@natisbad.org>
Message-ID: <20141121203436.GH20238@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +			poweroff at 12100 {
> +				compatible = "synology,power-off";
> +				reg = <0x12100 0x100>;
> +				clocks = <&coreclk 0>;
> +			};

So we have power off using the PIC.

> +	poweroff_pin: poweroff-pin {
> +		marvell,pins = "mpp4";
> +		marvell,function = "gpio";
> +	};

Do you know what this pin is used for?

   Andrew
