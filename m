From: robh@kernel.org (Rob Herring)
Date: Wed, 6 Dec 2017 15:57:06 -0600
Subject: [PATCH v3 03/15] dt-bindings: display: sun4i-drm: Add LVDS
 properties
In-Reply-To: <17851ba6277b69aa9cd81de5eead62bfed271661.1512486553.git-series.maxime.ripard@free-electrons.com>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
 <17851ba6277b69aa9cd81de5eead62bfed271661.1512486553.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20171206215706.sthymdcegp2nenwx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 04:10:15PM +0100, Maxime Ripard wrote:
> Some clocks and resets supposed to drive the LVDS logic in the display
> engine have been overlooked when the driver was first introduced.
> 
> Add those additional resources to the binding, and we'll deal with the ABI
> stability in the code.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 8 +++++++-
>  1 file changed, 8 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
