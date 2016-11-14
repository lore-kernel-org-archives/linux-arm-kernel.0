From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Nov 2016 14:38:29 +0800
Subject: [PATCH] ARM: dts: imx7d-pinfunc: fix UART pinmux defines
In-Reply-To: <20161109024456.1832-1-stefan@agner.ch>
References: <20161109024456.1832-1-stefan@agner.ch>
Message-ID: <20161114063827.GJ3310@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 06:44:56PM -0800, Stefan Agner wrote:
> The UART pinmux defines for the pins which are part of the LPSR
> pinmux controller are wrong: Output signals configure the input
> sel value and the pinmux defines allow not to distinguish between
> DCE/DTE mode. Follow the usual pattern using DTE/DCE as part of
> the define to denote the two UART configuration options.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
