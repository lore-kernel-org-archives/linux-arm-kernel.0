From: robh@kernel.org (Rob Herring)
Date: Mon, 14 Nov 2016 18:05:55 -0600
Subject: [PATCH v2 01/30] usb: dwc2: Deprecate g-use-dma binding
In-Reply-To: <966d342a5a7fee9ac3ef8140b60c228c4a87c7d3.1478748145.git.johnyoun@synopsys.com>
References: <cover.1478748145.git.johnyoun@synopsys.com>
 <966d342a5a7fee9ac3ef8140b60c228c4a87c7d3.1478748145.git.johnyoun@synopsys.com>
Message-ID: <20161115000555.fqemw7uuvphqpe2b@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 07:27:40PM -0800, John Youn wrote:
> This is not needed as the gadget now fully supports DMA and it can
> autodetect it. This was initially added because gadget DMA mode was only
> partially implemented so could not be automatically enabled.
> 
> Signed-off-by: John Youn <johnyoun@synopsys.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.txt |  4 +++-
>  arch/arm/boot/dts/rk3036.dtsi                  |  1 -
>  arch/arm/boot/dts/rk3288.dtsi                  |  1 -
>  arch/arm/boot/dts/rk3xxx.dtsi                  |  1 -
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi      |  1 -
>  arch/arm64/boot/dts/rockchip/rk3368.dtsi       |  1 -
>  drivers/usb/dwc2/core.h                        |  4 +---
>  drivers/usb/dwc2/params.c                      | 17 ++++++++++++++---
>  drivers/usb/dwc2/pci.c                         |  1 -
>  9 files changed, 18 insertions(+), 13 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
