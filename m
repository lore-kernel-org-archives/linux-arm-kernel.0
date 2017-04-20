From: robh@kernel.org (Rob Herring)
Date: Thu, 20 Apr 2017 09:21:35 -0500
Subject: [PATCH 1/3] Documentation: dt-bindings: iio: adc: add Meson8 and
 Meson8b support
In-Reply-To: <20170417182820.26670-2-martin.blumenstingl@googlemail.com>
References: <20170417182820.26670-1-martin.blumenstingl@googlemail.com>
 <20170417182820.26670-2-martin.blumenstingl@googlemail.com>
Message-ID: <20170420142135.4abputt7z4pkvvdx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 17, 2017 at 08:28:18PM +0200, Martin Blumenstingl wrote:
> The Amlogic Meson SAR ADC driver can be used on Meson8 and Meson8b
> (probably on earlier SoC generations as well, but I don't have any
> hardware available for testing that).
> Add a separate compatible for Meson8 and Meson8b because it does not
> need any of the BL30 magic (unlike the GX SoCs).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 2 ++
>  1 file changed, 2 insertions(+)

I'd prefer "Documentation: " prefix is dropped as that's implied with 
"dt-bindings". Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
