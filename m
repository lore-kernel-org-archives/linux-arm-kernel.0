From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 22:04:00 +0200
Subject: [PATCH 1/9] ARM: Kirkwood: Convert TS219 to pinctrl.
In-Reply-To: <20121024220021.148a88ff@skate>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <1351090434-30499-2-git-send-email-andrew@lunn.ch>
 <20121024213128.2d4c07dc@skate> <50884659.1020208@gmail.com>
 <20121024220021.148a88ff@skate>
Message-ID: <20121024200400.GZ21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I think what Shawn Guo did with i.MX 28 is really neat. In the current
> patches posted by Andrew, for example, the following piece:
> 
> +			pmx_uart1: pmx-uart1 {
> +				marvell,pins = "mpp13", "mpp14";
> +				marvell,function = "uart1";
> +			};
> 
> is needlessly repeated in kirkwood-ts219-6281.dts,
> kirkwood-ts219-6282.dts and kirkwood-dnskw.dtsi. This is clearly a
> pinmux configuration that sets up TXD/RXD of UART1, and it should be in
> kirkwood.dtsi.

I did try that, but was getting errors from dtc.

  Andrew
