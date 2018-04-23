From: horms@verge.net.au (Simon Horman)
Date: Mon, 23 Apr 2018 09:54:41 +0200
Subject: [PATCH 3/8] [media] v4l: rcar_fdp1: Change platform dependency
 to ARCH_RENESAS
In-Reply-To: <1524230914-10175-4-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-4-git-send-email-geert+renesas@glider.be>
Message-ID: <20180423075441.pbopbimq5m75apgz@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 03:28:29PM +0200, Geert Uytterhoeven wrote:
> The Renesas Fine Display Processor driver is used on Renesas R-Car SoCs
> only.  Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce
> ARCH_RENESAS") is ARCH_RENESAS a more appropriate platform dependency
> than the legacy ARCH_SHMOBILE, hence use the former.
> 
> This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
> future.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
