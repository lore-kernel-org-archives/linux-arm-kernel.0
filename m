From: robh@kernel.org (Rob Herring)
Date: Tue, 30 Oct 2018 15:28:31 -0500
Subject: [PATCH v3 22/25] dt-bindings: sun6i-dsi: Add compatible for A64
 DPHY
In-Reply-To: <20181026144344.27778-23-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-23-jagan@amarulasolutions.com>
Message-ID: <20181030202831.GA22352@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Oct 2018 20:13:41 +0530, Jagan Teki wrote:
> The MIPI DSI PHY HDMI controller on Allwinner A64 is similar
> on the one on A31.
> 
> Add A64 compatible and append A31 compatible as fallback.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - none
> Changes for v2:
> - new patch
> 
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
