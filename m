From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Mar 2018 07:52:14 -0500
Subject: [PATCH 2/8] drm/sun4i: Add DT binding for Detail Enhancement
 Unit in Allwinner A80 SoC
In-Reply-To: <20180315114136.24747-3-wens@csie.org>
References: <20180315114136.24747-1-wens@csie.org>
 <20180315114136.24747-3-wens@csie.org>
Message-ID: <20180318030113.756rexmhlkrqnmlg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 07:41:30PM +0800, Chen-Yu Tsai wrote:
> The display pipeline on the A80 SoC has what is called the Detail
> Enhancement Unit, or DEU for short, block in between the display
> frontend and backend. This unit can sharpen images in both luma
> and chroma channels. It seems to also do colorspace conversion.
> 
> This patch adds the device tree binding for this hardware block.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../bindings/display/sunxi/sun4i-drm.txt           | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
