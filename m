From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 29 Nov 2017 11:11:08 +0800
Subject: [PATCH] ARM: dts: imx6qdl-udoo: disable AC'97 input pins pad
 drivers
In-Reply-To: <94862a4d-bec5-cf19-95e6-512d88dd07dc@maciej.szmigiero.name>
References: <94862a4d-bec5-cf19-95e6-512d88dd07dc@maciej.szmigiero.name>
Message-ID: <20171129031107.GC9376@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 08:08:30PM +0100, Maciej S. Szmigiero wrote:
> AC'97 interface RXD and TXC pins are only used as SoC inputs, let's disable
> pad drivers for them so we will be protected if, for example, TCLKDIR is
> set by mistake in AUDMUX and causes TXC pin to be configured as an output.
> 
> This also changes pull direction on these pins from pull-up to pull-down
> to match what the board AC'97 CODEC chip (VT1613) has on these pins.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Applied, thanks.
