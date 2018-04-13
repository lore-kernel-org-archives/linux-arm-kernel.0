From: robh@kernel.org (Rob Herring)
Date: Fri, 13 Apr 2018 12:20:55 -0500
Subject: [PATCH 2/3] dt-bindings: interrupt-controller: New binding for
 Meson-AXG SoC
In-Reply-To: <20180408145700.23520-3-yixun.lan@amlogic.com>
References: <20180408145700.23520-1-yixun.lan@amlogic.com>
 <20180408145700.23520-3-yixun.lan@amlogic.com>
Message-ID: <20180413172055.waibtio6qbltdv4a@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 08, 2018 at 02:56:59PM +0000, Yixun Lan wrote:
> Update the dt-binding documentation to support new compatible string
> for the GPIO interrupt controller which found in Amlogic's Meson-AXG SoC.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
