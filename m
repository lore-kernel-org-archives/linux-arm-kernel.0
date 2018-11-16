From: robh@kernel.org (Rob Herring)
Date: Fri, 16 Nov 2018 17:19:16 -0600
Subject: [PATCH v4 17/26] dt-bindings: sun6i-dsi: Add VCC-DSI supply
 property
In-Reply-To: <20181113111633.20189-18-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-18-jagan@amarulasolutions.com>
Message-ID: <20181116231916.GA1222@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Nov 2018 16:46:24 +0530, Jagan Teki wrote:
> Most of the Allwinner MIPI DSI controllers are supply with
> VCC-DSI pin. which need to supply for some of the boards to
> trigger the power.
> 
> So, document the supply property so-that the required board
> can eable it via device tree.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
