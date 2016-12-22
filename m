From: robh@kernel.org (Rob Herring)
Date: Thu, 22 Dec 2016 15:00:44 -0600
Subject: [PATCH v4 4/5] mfd: dt: Add bindings for the Aspeed LPC Host
 Controller (LHC)
In-Reply-To: <20161220071535.27542-5-andrew@aj.id.au>
References: <20161220071535.27542-1-andrew@aj.id.au>
 <20161220071535.27542-5-andrew@aj.id.au>
Message-ID: <20161222210044.iwrackjlmroi6tl7@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2016 at 05:45:34PM +1030, Andrew Jeffery wrote:
> The LPC bus pinmux configuration on fifth generation Aspeed SoCs depends
> on bits in both the System Control Unit and the LPC Host Controller.
> 
> The Aspeed LPC Host Controller is described as a child node of the
> LPC host-range syscon device for arbitration of access by the host
> controller and pinmux drivers.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> 
> Linus: I've retained your r-b tag I don't think the addition of the ast2400
> compatible string will fuss you. Please let me know if you feel this is
> inappropriate.
> 
>  .../devicetree/bindings/mfd/aspeed-lpc.txt         | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
