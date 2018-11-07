From: horms@verge.net.au (Simon Horman)
Date: Wed, 7 Nov 2018 12:19:32 +0100
Subject: [PATCH V3] arm64: dts: r8a77990: ebisu: Add and enable SDHI
 device nodes
In-Reply-To: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
References: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
Message-ID: <20181107111932.s5z6xoivcebwehfs@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 09:46:47PM +0100, Marek Vasut wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> This patch adds SDHI{0,1,3} device nodes for the r8a77990 SoC
> and enables SD card slot connected to SDHI0, micro SD card slot
> connected to SDHI1 and eMMC connected to SDHI3 on the Ebisu board
> using the R8A77990 SoC.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
> V2: - Deduplicated regular and UHS pins
>     - Added sdhi3_ds pin pinmux
> V3: - Squash two patches, one adding SDHI nodes to R8A77990 E3 DTSI
>       and another enabling them on E3 Ebisu, together.
> ---
>  .../arm64/boot/dts/renesas/r8a77990-ebisu.dts | 130 ++++++++++++++++++
>  arch/arm64/boot/dts/renesas/r8a77990.dtsi     |  36 +++++
>  2 files changed, 166 insertions(+)

Thanks, applied for v4.21.
