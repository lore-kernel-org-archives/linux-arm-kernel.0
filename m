From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jun 2018 13:17:08 -0600
Subject: [PATCH v2 18/27] dt-bindings: display: sun4i-drm: Add
 description of A64 HDMI PHY
In-Reply-To: <20180612200036.21483-19-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-19-jernej.skrabec@siol.net>
Message-ID: <20180620191708.GA6846@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 10:00:27PM +0200, Jernej Skrabec wrote:
> A64 HDMI PHY is similar to H3 HDMI PHY except it has two possible PLL
> clock parents. It is compatible to other HDMI PHYs, like that found in
> R40.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
