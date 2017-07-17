From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Jul 2017 13:51:26 -0500
Subject: [PATCH 07/11] mmc: sunxi: Add support for A83T eMMC (MMC2)
In-Reply-To: <20170714064302.20383-8-wens@csie.org>
References: <20170714064302.20383-1-wens@csie.org>
 <20170714064302.20383-8-wens@csie.org>
Message-ID: <20170717185126.rrhriqckjextpaxj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 02:42:58PM +0800, Chen-Yu Tsai wrote:
> The third MMC controller (MMC2) on the Allwinner A83T SoC is slightly
> different. It supports a wider 8-bit bus, has a dedicated controllable
> reset pin for eMMC, and a "new timing mode" which is supposed to deliver
> better signals and thus better performance.
> 
> Add a compatible for this one to use the new timing mode not found in the
> other controllers.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/mmc/host/sunxi-mmc.c                        | 8 ++++++++
>  2 files changed, 9 insertions(+)
