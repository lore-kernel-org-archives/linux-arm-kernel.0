From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 13:10:25 -0500
Subject: [PATCH v2 14/26] dt-bindings: display: Add compatible for A64 HDMI
In-Reply-To: <20180518094536.17201-15-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
 <20180518094536.17201-15-jagan@amarulasolutions.com>
Message-ID: <20180522181025.GA20871@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 03:15:24PM +0530, Jagan Teki wrote:
> HDMI on Allwinner A64 has similar like H3/H5/A83T.
> 
> Add compatible a64 and update A83T compatible as fallback.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - Add fallback compatible
> 
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
