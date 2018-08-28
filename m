From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 28 Aug 2018 12:42:11 +0200
Subject: [PATCH] memory: Convert to using %pOFn instead of device_node.name
In-Reply-To: <20180828015252.28511-29-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-29-robh@kernel.org>
Message-ID: <20180828104211.GA9386@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 08:52:30PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-tegra at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/memory/omap-gpmc.c           | 18 +++++++-----------
>  drivers/memory/samsung/exynos-srom.c |  4 ++--
>  drivers/memory/tegra/mc.c            |  6 +++---
>  drivers/memory/tegra/tegra124-emc.c  | 12 ++++++------
>  4 files changed, 18 insertions(+), 22 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180828/105c2564/attachment-0001.sig>
