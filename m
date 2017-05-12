From: robh@kernel.org (Rob Herring)
Date: Fri, 12 May 2017 14:05:21 -0500
Subject: [RFC 1/2] dt-bindings: mmc: Document the Amlogic Meson8 and
 Meson8b SDIO bindings
In-Reply-To: <20170506171857.16492-2-martin.blumenstingl@googlemail.com>
References: <20170506171857.16492-1-martin.blumenstingl@googlemail.com>
 <20170506171857.16492-2-martin.blumenstingl@googlemail.com>
Message-ID: <20170512190521.ewkmqnmmscop52fa@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 06, 2017 at 07:18:56PM +0200, Martin Blumenstingl wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> This documents the devicetree bindings for the SDIO/MMC host found in
> Amlogic Meson8 and Meson8b SoCs. It supports the SD specification v2.0
> and the eMMC specification v4.41.
> It has an internal "mux" which allows connecting up to three MMC devices
> to it. The maximum supported bus-width is 4-bits.
> 
> Amlogic's GPL kernel sources call it "SDIO" to differentiate it from the
> other MMC controller in (at least the Meson8 and Meson8b) the SoCs (they
> call the other one "SDHC", which supports a bus-width of up to 8-bits).
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/mmc/amlogic,meson-mx-sdio.txt         | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt

Acked-by: Rob Herring <robh@kernel.org>
