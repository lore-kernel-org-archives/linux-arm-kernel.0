From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 13:10:00 -0500
Subject: [PATCH v2 07/26] dt-bindings: display: Add compatible for A64
 DE2 tcon1 blocks
In-Reply-To: <20180518094536.17201-8-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
 <20180518094536.17201-8-jagan@amarulasolutions.com>
Message-ID: <20180522181000.GA19875@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 03:15:17PM +0530, Jagan Teki wrote:
> Allwinner A64 has DE2 pipeline with tcon0 and tcon1 block
> which is similar Allwinner A83T.
> 
> This patch adds dt-binding documentation for A64 DE2 tcon1 blocks.
> 
> Mixer1 has different configuration for A64 so use separate compatible
> but tcon1 has similar behaviour with A83T so add fallback compatible.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - Add fallback compatible for tcon1
> - Add separate compatible for mixer1 
> 
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
