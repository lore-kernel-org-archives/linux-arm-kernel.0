From: robh@kernel.org (Rob Herring)
Date: Mon, 15 Oct 2018 13:24:02 -0500
Subject: [PATCH 03/12] dt-bindings: sun6i-dsi: Add compatible for A64
 MIPI DSI
In-Reply-To: <20180927114850.24565-4-jagan@amarulasolutions.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-4-jagan@amarulasolutions.com>
Message-ID: <20181015182402.GA5988@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Sep 2018 17:18:41 +0530, Jagan Teki wrote:
> The MIPI DSI controller on Allwinner A64 is similar to
> Allwinner A31 without support of DSI mod clock.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
