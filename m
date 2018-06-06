From: horms@verge.net.au (Simon Horman)
Date: Wed, 6 Jun 2018 11:04:00 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Enable watchdog
 timer
In-Reply-To: <1528219234-29348-1-git-send-email-geert+renesas@glider.be>
References: <1528219234-29348-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20180606090359.zi46cq5ddftdaps7@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2018 at 07:20:34PM +0200, Geert Uytterhoeven wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> Add a device node for the Watchdog Timer (WDT) controller on the
> R8A77990 SoC, and enable the watchdog on the Ebisu board.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [geert: Squashed 2 commits]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Hi,

This looks fine to me but I will wait to see if there are other reviews
before applying.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
