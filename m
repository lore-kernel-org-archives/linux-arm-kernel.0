From: robh@kernel.org (Rob Herring)
Date: Fri, 13 Oct 2017 14:29:12 -0500
Subject: [PATCH 1/6] phy: sun4i-usb: add support for R40 USB PHY
In-Reply-To: <20171008042906.46779-2-icenowy@aosc.io>
References: <20171008042906.46779-1-icenowy@aosc.io>
 <20171008042906.46779-2-icenowy@aosc.io>
Message-ID: <20171013192912.vt2co5ea5howiczz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 08, 2017 at 12:29:01PM +0800, Icenowy Zheng wrote:
> Allwinner R40 features a USB PHY like the one in A64, but with 3 PHYs.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt |  1 +
>  drivers/phy/allwinner/phy-sun4i-usb.c                   | 12 ++++++++++++
>  2 files changed, 13 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
