From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Apr 2017 08:24:34 -0500
Subject: [PATCH 1/2] drm/sun4i: Add display backend interrupt to device
 tree binding
In-Reply-To: <20170327143847.16259-2-wens@csie.org>
References: <20170327143847.16259-1-wens@csie.org>
 <20170327143847.16259-2-wens@csie.org>
Message-ID: <20170403132434.v6nvj6hgaxnwmsej@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 10:38:46PM +0800, Chen-Yu Tsai wrote:
> The display backend has an interrupt line. Add it to the device tree
> binding.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
