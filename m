From: robh@kernel.org (Rob Herring)
Date: Sat, 8 Oct 2016 20:28:25 -0500
Subject: [PATCH v3 1/3] Documentation: dt-bindings: update the
 meson-usb2-phy example
In-Reply-To: <20161001121900.1168-2-martin.blumenstingl@googlemail.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20161001121900.1168-1-martin.blumenstingl@googlemail.com>
 <20161001121900.1168-2-martin.blumenstingl@googlemail.com>
Message-ID: <20161009012825.GC18158@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 01, 2016 at 02:18:58PM +0200, Martin Blumenstingl wrote:
> Update the example so the node name uses a dash (instead of an
> underscore) as per convention.
> Additionally it updates the example register offset to a real example
> (the old value was taken from a draft where there was an additional PHY
> bus).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/phy/meson-usb2-phy.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
