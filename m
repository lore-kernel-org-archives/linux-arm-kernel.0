From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Jul 2018 16:04:35 -0600
Subject: [PATCH 1/2] dt-bindings: amlogic: Add support for GXL S805X and
 the P241 board
In-Reply-To: <1530784243-20823-2-git-send-email-narmstrong@baylibre.com>
References: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com>
 <1530784243-20823-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <20180716220435.GA22633@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2018 at 11:50:42AM +0200, Neil Armstrong wrote:
> The S805X is a variant of the Amlogic Meson GXL SoC family with the
> following physical limitations :
> - No SDCard interface
> - No GPIOCLK pins
> - No USB OTG ID pin (but Gadget feature can stil be forced)
> - No 5V regulator
> - Reduced ADC inputs (only ADC0 and ADC1)
> - GPIODV_26, GPIOAO_3, GPIOAO_4, GPIOAO_5, GPIOAO_6, GPIOX_14,
>   GPIOX_15, GPIOH_3 are no more exposed on the package
> 
> Amlogic exposes the following SW limitations :
> - HDMI max resolution should be 1080p60, VPU clock should be downgraded
> - Video Decoding should be limited to 1080p60, VDEC clock should be downgraded
> - CPU speed should be limited by SCPI OPP table to 1.2GHz
> - DRAM interface is limited to DDR4 16bit up to 1GiB
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
