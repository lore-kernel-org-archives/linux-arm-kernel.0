From: robh@kernel.org (Rob Herring)
Date: Sat, 17 Nov 2018 10:21:33 -0600
Subject: [PATCH 3/4] Documentation: bindings: Add missing Amlogic SCPI
 sensor bindings
In-Reply-To: <20181108135352.8459-4-jbrunet@baylibre.com>
References: <20181108135352.8459-1-jbrunet@baylibre.com>
 <20181108135352.8459-4-jbrunet@baylibre.com>
Message-ID: <20181117162133.GA25151@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  8 Nov 2018 14:53:51 +0100, Jerome Brunet wrote:
> amlogic,meson-gxbb-scpi-sensors is both the driver and DT but is not
> documented. Just add it to amlogic's scpi documentation
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic,scpi.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
