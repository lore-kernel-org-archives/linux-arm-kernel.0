From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 May 2014 01:23:59 -0400
Subject: [PATCHv2] ARM: Kirkwood: DT versions of OpenRD boards
In-Reply-To: <1399836639-1918-1-git-send-email-andrew@lunn.ch>
References: <1399836639-1918-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140516052359.GA27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 11, 2014 at 09:30:39PM +0200, Andrew Lunn wrote:
> Create DTS files to describe the Marvell OpenRD boards.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Francois Lorrain <francois.lorrain@gmail.com>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> s/descrition/description/
> Remove i2c pinctrl properties
> Fixed status of mvsdio node.
> ---
>  arch/arm/boot/dts/Makefile                     |  3 +
>  arch/arm/boot/dts/kirkwood-openrd-base.dts     | 42 ++++++++++++
>  arch/arm/boot/dts/kirkwood-openrd-client.dts   | 73 +++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-openrd-ultimate.dts | 58 +++++++++++++++++
>  arch/arm/boot/dts/kirkwood-openrd.dtsi         | 90 ++++++++++++++++++++++++++
>  5 files changed, 266 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-openrd-base.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-openrd-client.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-openrd-ultimate.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-openrd.dtsi

Applied to mvebu/dt

thx,

Jason.
