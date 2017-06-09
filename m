From: robh@kernel.org (Rob Herring)
Date: Fri, 9 Jun 2017 08:53:28 -0500
Subject: [PATCH 3/3] Documentation: dt-bindings: Document deprecation of
 "vmmc_aux" and using "vqmmc"
In-Reply-To: <20170607083612.14224-4-kishon@ti.com>
References: <20170607083612.14224-1-kishon@ti.com>
 <20170607083612.14224-4-kishon@ti.com>
Message-ID: <20170609135328.frpf36hk242b3dxh@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 02:06:12PM +0530, Kishon Vijay Abraham I wrote:
> Document deprecation of "vmmc_aux" for io regulator and use of generic
> mmc binding "vqmmc" in omap-hsmmc.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
