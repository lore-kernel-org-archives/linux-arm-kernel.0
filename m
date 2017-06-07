From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Jun 2017 17:37:17 -0500
Subject: [PATCH 06/19] dt-bindings: display: sun4i: Add binding for A31
 HDMI controller
In-Reply-To: <20170602101024.18940-7-wens@csie.org>
References: <20170602101024.18940-1-wens@csie.org>
 <20170602101024.18940-7-wens@csie.org>
Message-ID: <20170607223717.uoh45hhcqugakdk6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 06:10:11PM +0800, Chen-Yu Tsai wrote:
> The HDMI controller in the A31 SoC is slightly different from the
> earlier version. In addition to the TMDS clock and DDC controls,
> this version now takes a second DDC clock input.
> 
> Add a compatible string for it, and add the DDC clock input to the
> list of clocks required.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
