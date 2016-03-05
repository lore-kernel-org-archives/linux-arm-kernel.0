From: robh@kernel.org (Rob Herring)
Date: Fri, 4 Mar 2016 22:28:49 -0600
Subject: [PATCH 1/2] ARM: OMAP2+: hwmod: Introduce ti,no-idle dt property
In-Reply-To: <1456994525-20573-2-git-send-email-lokeshvutla@ti.com>
References: <1456994525-20573-1-git-send-email-lokeshvutla@ti.com>
 <1456994525-20573-2-git-send-email-lokeshvutla@ti.com>
Message-ID: <20160305042849.GV13525@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 02:12:04PM +0530, Lokesh Vutla wrote:
> Introduce a dt property, ti,no-idle, that prevents an IP to idle at any
> point. This is to handle Errata i877, which tells that GMAC clocks
> cannot be disabled.
> 
> Acked-by: Roger Quadros <rogerq@ti.com>
> Tested-by: Mugunthan V N <mugunthanvnm@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/omap/omap.txt | 1 +

Acked-by: Rob Herring <robh@kernel.org>

>  arch/arm/mach-omap2/omap_hwmod.c                    | 9 ++++++++-
>  arch/arm/mach-omap2/omap_hwmod.h                    | 3 +++
>  3 files changed, 12 insertions(+), 1 deletion(-)
