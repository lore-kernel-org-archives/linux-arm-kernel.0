From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 12:09:51 -0500
Subject: [PATCH 2/8] dt-bindings: phy: sun4i-usb-phy: Add compatible
 string for A83T
In-Reply-To: <20170803081411.22389-3-wens@csie.org>
References: <20170803081411.22389-1-wens@csie.org>
 <20170803081411.22389-3-wens@csie.org>
Message-ID: <20170810170951.bacpgjwplmm5fz7g@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 03, 2017 at 04:14:05PM +0800, Chen-Yu Tsai wrote:
> The A83T has 3 USB PHYs, 1 for OTG, 1 for standard USB, 1 for USB HSIC.
> 
> Add a compatible string for it, and describe the needed properties.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
