From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 3 Jan 2017 17:36:09 +0100
Subject: [PATCH 1/8] ARM: dts: armada-370-rd: Utilize new DSA binding
In-Reply-To: <20170102022249.10657-2-f.fainelli@gmail.com>
References: <20170102022249.10657-1-f.fainelli@gmail.com>
 <20170102022249.10657-2-f.fainelli@gmail.com>
Message-ID: <20170103163609.GE32450@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +
> +	switch: switch at 10 {
> +		compatible = "marvell,mv88e6085";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <16>;

Hummm, a device tree question. switch at 10, reg = <16>. Is there an
implicit understanding that the 10 is hex?

	 Andrew
