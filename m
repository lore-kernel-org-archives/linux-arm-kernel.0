From: horms@verge.net.au (Simon Horman)
Date: Fri, 8 Jun 2018 10:00:55 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Enable watchdog
 timer
In-Reply-To: <20180606090359.zi46cq5ddftdaps7@verge.net.au>
References: <1528219234-29348-1-git-send-email-geert+renesas@glider.be>
 <20180606090359.zi46cq5ddftdaps7@verge.net.au>
Message-ID: <20180608080055.2gvrvnjpxkfy2men@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2018 at 11:04:00AM +0200, Simon Horman wrote:
> On Tue, Jun 05, 2018 at 07:20:34PM +0200, Geert Uytterhoeven wrote:
> > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > 
> > Add a device node for the Watchdog Timer (WDT) controller on the
> > R8A77990 SoC, and enable the watchdog on the Ebisu board.
> > 
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > [geert: Squashed 2 commits]
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Hi,
> 
> This looks fine to me but I will wait to see if there are other reviews
> before applying.
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thanks Geert, applied
