From: horms@verge.net.au (Simon Horman)
Date: Thu, 15 Feb 2018 17:20:29 +0100
Subject: [PATCH v6 09/26] soc: renesas: rcar-rst: Enable watchdog as
 reset trigger for Gen2
In-Reply-To: <1518526964-7400-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <20180213081910.x5llcsmwza44u4ow@verge.net.au>
 <1518526964-7400-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20180215162029.s7rus3f3zaru7spz@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 01:02:44PM +0000, Fabrizio Castro wrote:
> This patch allows for platform specific quirks as some of the SoC need
> further customization for the watchdog to work properly, like for R-Car
> Gen2 and for RZ/G.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> ---
> v5->v6:
> * rebased on top of renesas-devel-20180213-v4.16-rc1

Thanks, applied.
