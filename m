From: horms@verge.net.au (Simon Horman)
Date: Wed, 21 Nov 2018 11:00:22 +0100
Subject: [PATCH V2] arm64: dts: renesas: r8a77965: Add CAN and CANFD
 controller nodes
In-Reply-To: <20181120233252.1612-1-marek.vasut+renesas@gmail.com>
References: <20181120233252.1612-1-marek.vasut+renesas@gmail.com>
Message-ID: <20181121100022.s2jvqw6fc4ixve7l@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 12:32:52AM +0100, Marek Vasut wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> This patch adds CAN{0,1} and CANFD controller nodes for the R8A77965 SoC.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
> V2: Squash the CAN and CANFD addition patches together.
> ---
>  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 51 ++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 2 deletions(-)

Thanks Marek,

applied for v4.21.
