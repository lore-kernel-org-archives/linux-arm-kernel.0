From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 23 Jun 2015 21:36:53 +0200
Subject: [PATCH 2/3] arm64: dts: mt8173: Use real clock for UARTs
In-Reply-To: <1432128766-4445-3-git-send-email-s.hauer@pengutronix.de>
References: <1432128766-4445-1-git-send-email-s.hauer@pengutronix.de>
 <1432128766-4445-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4544810.sNeuKeAioW@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, May 20, 2015 03:32:45 PM Sascha Hauer wrote:
> We used to use a fixed rate clock for the UARTs. Now that we have clock
> support we can associate the correct clocks to the UARTs and drop the
> 26MHz fixed rate UART clock.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 

Applied now to v4.2-next/arm64
