From: horms@verge.net.au (Simon Horman)
Date: Tue, 13 Feb 2018 09:19:10 +0100
Subject: [PATCH v5 09/26] soc: renesas: rcar-rst: Enable watchdog as
 reset trigger for Gen2
In-Reply-To: <1518457475-4480-10-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1518457475-4480-10-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20180213081910.x5llcsmwza44u4ow@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 05:44:18PM +0000, Fabrizio Castro wrote:
> This patch allows for platform specific quirks as some of the SoC need
> further customization for the watchdog to work properly, like for R-Car
> Gen2 and for RZ/G.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

I am fine with this patch but please rebase it on top of
renesas-devel-20180212-v4.16-rc1 (or later).
