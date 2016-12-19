From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Dec 2016 15:44:04 +0100
Subject: [PATCH 4/4] arm64: dts: marvell: Add ethernet switch definition
 for the EXPRESSObin
In-Reply-To: <20161219141610.30934-5-romain.perier@free-electrons.com>
References: <20161219141610.30934-1-romain.perier@free-electrons.com>
 <20161219141610.30934-5-romain.perier@free-electrons.com>
Message-ID: <20161219144404.GB10048@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +		mdio {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			switch0phy0: switch0phy0 at 0 {
> +				reg = <0x11>;

Since the reg is 0x11, this should be called switch0phy0 at 11.  Please
follow the same scheme for the other phys.

       Andrew
