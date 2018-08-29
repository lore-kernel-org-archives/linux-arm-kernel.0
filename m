From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 29 Aug 2018 09:44:59 +0200
Subject: [PATCH] memory: Convert to using %pOFn instead of device_node.name
In-Reply-To: <20180828015252.28511-29-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-29-robh@kernel.org>
Message-ID: <CAJKOXPdtVA14+DFmL_LYy-UZ1Enq06TxazDLW8c8ihn_+vw8Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Aug 2018 at 03:54, Rob Herring <robh@kernel.org> wrote:
>
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

For Samsung:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
