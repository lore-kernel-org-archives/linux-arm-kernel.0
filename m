From: horms@verge.net.au (Simon Horman)
Date: Mon, 19 Nov 2018 11:34:22 +0100
Subject: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Add and enable
 PCIe device node
In-Reply-To: <20181113192226.17762-1-marek.vasut+renesas@gmail.com>
References: <20181113192226.17762-1-marek.vasut+renesas@gmail.com>
Message-ID: <20181119103422.573mtgkfka5onfhx@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 08:22:26PM +0100, Marek Vasut wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> This patch adds PCI express channel 0 device node to the R8A77990 SoC
> and enables PCIEC0 PCI express controller on the Ebisu board.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> To: devicetree at vger.kernel.org
> ---
>  .../arm64/boot/dts/renesas/r8a77990-ebisu.dts |  8 +++++
>  arch/arm64/boot/dts/renesas/r8a77990.dtsi     | 34 +++++++++++++++++++
>  2 files changed, 42 insertions(+)

Thanks Marek,

applied for v4.21.
