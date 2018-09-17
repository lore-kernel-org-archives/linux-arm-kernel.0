From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Sep 2018 01:44:46 -0400
Subject: [PATCH 18/27] dt-bindings: display: sunxi: add DT binding for
 Allwinner H6 DW HDMI
In-Reply-To: <20180902072643.4917-19-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-19-jernej.skrabec@siol.net>
Message-ID: <5b9f3f4f.1c69fb81.e9b3c.3a5f@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  2 Sep 2018 09:26:34 +0200, Jernej Skrabec wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> The Allwinner H6 SoC uses a v2.12a DesignWare HDMI controller, with
> dedicated CEC and HDCP clocks added; the PHY connected is a standard
> DesignWare HDMI PHY.
> 
> Add binding for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> [added HDCP clock and reset]
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../devicetree/bindings/display/sunxi/sun4i-drm.txt   | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
