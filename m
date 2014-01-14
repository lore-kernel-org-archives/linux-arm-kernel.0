From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 Jan 2014 19:48:33 -0500
Subject: [PATCH] ARM: Kirkwood: Add DT description of QNAP 419
In-Reply-To: <1389048557-16364-1-git-send-email-andrew@lunn.ch>
References: <1389048557-16364-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140114004833.GI19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 11:49:17PM +0100, Andrew Lunn wrote:
> Re-implement the Marvell Kirkwood ts41x-setup.c in DT.
> 
> As with the QNAP 119, there are two variants, depending on which SoC
> has been used. They differ on Ethernet PHY addresses and number of
> PCIe busses.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/Makefile                |    4 +-
>  arch/arm/boot/dts/kirkwood-ts419-6281.dts |   20 ++++++++
>  arch/arm/boot/dts/kirkwood-ts419-6282.dts |   32 ++++++++++++
>  arch/arm/boot/dts/kirkwood-ts419.dtsi     |   75 +++++++++++++++++++++++++++++
>  4 files changed, 130 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-ts419-6281.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ts419-6282.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ts419.dtsi

Applied to mvebu/dt with Ian's Tested-by

thx,

Jason.
