From: horms@verge.net.au (Simon Horman)
Date: Mon, 23 Apr 2018 09:56:43 +0200
Subject: [PATCH 6/8] ASoC: sh: Update menu title and platform dependency
In-Reply-To: <1524230914-10175-7-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-7-git-send-email-geert+renesas@glider.be>
Message-ID: <20180423075642.avhihfr44se7dfz6@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 03:28:32PM +0200, Geert Uytterhoeven wrote:
> Change the menu title to refer to "Renesas SoCs" instead of "SuperH", as
> both SuperH and ARM SoCs are supported.
> 
> Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
> is ARCH_RENESAS a more appropriate platform dependency for Renesas ARM
> SoCs than the legacy ARCH_SHMOBILE, hence use the former.
> Renesas SuperH SH-Mobile SoCs are still covered by the SUPERH
> dependency.
> 
> This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
> future.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
