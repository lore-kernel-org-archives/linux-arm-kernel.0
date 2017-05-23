From: robh@kernel.org (Rob Herring)
Date: Tue, 23 May 2017 09:44:24 -0500
Subject: [PATCH 11/41] mmc: host: omap_hsmmc: Add new compatible string
 to support dra7
In-Reply-To: <20170519081541.26753-12-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
 <20170519081541.26753-12-kishon@ti.com>
Message-ID: <20170523144424.5aj5xl3vlwyuj6ws@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 01:45:11PM +0530, Kishon Vijay Abraham I wrote:
> Add a new compatible string "ti,dra7-hsmmc" to support
> dra7 and dra72 controllers. Also create a new controller flag
> "OMAP_HSMMC_REQUIRE_IODELAY" to specify all controllers that use
> "ti,dra7-hsmmc" require iodealy configuration to be set.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt |  1 +
>  drivers/mmc/host/omap_hsmmc.c                           | 10 ++++++++++
>  include/linux/platform_data/hsmmc-omap.h                |  1 +
>  3 files changed, 12 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
