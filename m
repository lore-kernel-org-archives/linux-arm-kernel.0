From: robh@kernel.org (Rob Herring)
Date: Fri, 5 Oct 2018 15:53:21 -0500
Subject: [PATCH v4 01/10] dt-bindings: phy: add binding for Allwinner H6
 USB2 PHY
In-Reply-To: <20181004122855.22981-2-icenowy@aosc.io>
References: <20181004122855.22981-1-icenowy@aosc.io>
 <20181004122855.22981-2-icenowy@aosc.io>
Message-ID: <20181005205321.GA2217@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  4 Oct 2018 20:28:46 +0800, Icenowy Zheng wrote:
> The USB2.0 PHY on Allwinner H6 is similar to the ones on the ones on
> older SoCs, but with holes in PHY number (USB1 and USB2 are missing, in
> which USB1 is a USB3 PHY).
> 
> Add binding for the PHY.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> New patch in v4.
> 
>  Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
