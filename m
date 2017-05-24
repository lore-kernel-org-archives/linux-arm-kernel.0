From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 May 2017 03:37:53 +0200
Subject: [PATCH v2] ARM: dts: mvebu: add support for Linksys WRT3200ACM
 (Rango)
In-Reply-To: <20170523212921.16684-1-ralph.sennhauser@gmail.com>
References: <20170523212921.16684-1-ralph.sennhauser@gmail.com>
Message-ID: <20170524013753.GA3770@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ralph

> Changes since v1:
> 
>   - Use non-removable with the sdhci node

..

> +
> +&sdhci {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdhci_pins>;
> +	no-1-8-v;
> +	broken-cd;
> +	wp-inverted;
> +	bus-width = <8>;
> +	status = "okay";
> +};

???

	Andrew
