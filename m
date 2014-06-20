From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 16:52:15 -0400
Subject: [PATCHv4 2/4] ARM: Kirkwood: Add DT descriptions for net2big
 and net5big.
In-Reply-To: <1401132591-26305-3-git-send-email-andrew@lunn.ch>
References: <1401132591-26305-1-git-send-email-andrew@lunn.ch>
 <1401132591-26305-3-git-send-email-andrew@lunn.ch>
Message-ID: <20140620205215.GM21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 09:29:49PM +0200, Andrew Lunn wrote:
> Describe LaCie 2Big and 5Big Network v2 using device tree.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> v1->v2
> Fix size of memory
> Clean up ethernet nodes
> s/at/atmel/
> 
> v2->v3
> gpio_poweroff->gpio-poweroff
> gpio_key->gpio-key
> s/ok/okay
> Remove spi pinctrl properties.
> 
> v3->v4
> Add _v2 to compatible name of devices
> Fix SoC version to 6281
> tabification of DT files
> Add fan controller and clock node for fan controller
> ---
>  arch/arm/boot/dts/Makefile              |   2 +
>  arch/arm/boot/dts/kirkwood-net2big.dts  |  30 ++++++
>  arch/arm/boot/dts/kirkwood-net5big.dts  |  83 +++++++++++++++
>  arch/arm/boot/dts/kirkwood-netxbig.dtsi | 180 ++++++++++++++++++++++++++++++++
>  4 files changed, 295 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-net2big.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-net5big.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-netxbig.dtsi

Applied to mvebu/dt

thx,

Jason.
