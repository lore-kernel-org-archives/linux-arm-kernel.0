From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 17:45:49 -0500
Subject: [RFC PATCH 02/10] dt-bindings: devfreq: rk3399_dmc: Add
 rockchip,pmu phandle.
In-Reply-To: <20180514211610.26618-3-enric.balletbo@collabora.com>
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
 <20180514211610.26618-3-enric.balletbo@collabora.com>
Message-ID: <20180522224549.GA26650@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 11:16:02PM +0200, Enric Balletbo i Serra wrote:
> The Rockchip DMC (Dynamic Memory Interface) needs to access to the PMU
> general register files to know the DRAM type, so add a phandle to the
> syscon that manages these registers.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
