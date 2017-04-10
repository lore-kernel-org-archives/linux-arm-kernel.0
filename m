From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Apr 2017 10:00:09 -0500
Subject: [PATCH V5 1/2] dt-bindings: thermal: add support for Broadcom's
 Northstar thermal
In-Reply-To: <20170403154829.29780-1-zajec5@gmail.com>
References: <20170331201124.656-1-zajec5@gmail.com>
 <20170403154829.29780-1-zajec5@gmail.com>
Message-ID: <20170410150009.b63cxumt2gy2vuuk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 05:48:28PM +0200, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> This commit documents binding for thermal used in Northstar family SoCs.
> 
> There isn't any known Northstar device with active cooling system so DT
> example has empty cooling-maps node. There is also no support for CPU
> frequency throttling so I put only a critical trip in the example.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> ---
> V3: Add thermal-zones to the example
> V5: Extend example by including trips and cooling-maps. Update commit message
> ---
>  .../devicetree/bindings/thermal/brcm,ns-thermal    | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal

Acked-by: Rob Herring <robh@kernel.org>
