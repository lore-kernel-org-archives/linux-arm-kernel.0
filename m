From: robh@kernel.org (Rob Herring)
Date: Tue, 20 Sep 2016 09:27:44 -0500
Subject: [PATCH v2 1/6] usb: dwc2: add support for Meson8b and GXBB SoCs
In-Reply-To: <20160911134111.31141-2-martin.blumenstingl@googlemail.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-2-martin.blumenstingl@googlemail.com>
Message-ID: <20160920142744.GA7675@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 11, 2016 at 03:41:06PM +0200, Martin Blumenstingl wrote:
> From: Jerome Brunet <jbrunet@baylibre.com>
> 
> Add compatible strings for amlogic Meson8b and GXBB SoCs with the
> corresponding configuration parameters.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.txt |  2 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/usb/dwc2/platform.c                    | 34 ++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
