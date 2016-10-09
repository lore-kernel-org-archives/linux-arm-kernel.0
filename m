From: robh@kernel.org (Rob Herring)
Date: Sat, 8 Oct 2016 20:28:37 -0500
Subject: [PATCH v3 2/3] Documentation: dt-bindings: rename meson-usb2-phy
 to meson8b-usb2-phy
In-Reply-To: <20161001121900.1168-3-martin.blumenstingl@googlemail.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20161001121900.1168-1-martin.blumenstingl@googlemail.com>
 <20161001121900.1168-3-martin.blumenstingl@googlemail.com>
Message-ID: <20161009012837.GD18158@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 01, 2016 at 02:18:59PM +0200, Martin Blumenstingl wrote:
> The corresponding driver only supports the USB PHY on Meson8b and GXBB
> SoCs. Newer SoC versions are using a different USB PHY implementation,
> which will mean that a new driver is required. Thus make sure that our
> naming is specific enough so it does not conflict with upcoming drivers.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/phy/{meson-usb2-phy.txt => meson8b-usb2-phy.txt}           | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/phy/{meson-usb2-phy.txt => meson8b-usb2-phy.txt} (95%)

Acked-by: Rob Herring <robh@kernel.org>
