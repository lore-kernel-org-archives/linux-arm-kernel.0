From: robh@kernel.org (Rob Herring)
Date: Fri, 25 Aug 2017 13:01:45 -0500
Subject: [PATCH v3 1/3] dt-bindings: usb: add DT binding for RK3328 dwc3
 controller
In-Reply-To: <1503322566-31489-2-git-send-email-william.wu@rock-chips.com>
References: <1503322566-31489-1-git-send-email-william.wu@rock-chips.com>
 <1503322566-31489-2-git-send-email-william.wu@rock-chips.com>
Message-ID: <20170825180145.cgpgkrjitwqkpmbz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 09:36:04PM +0800, William Wu wrote:
> Adds the device tree bindings description for RK3328 and
> compatible USB DWC3 controller.
> 
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> ---
> Changes in v3:
> - Add this for separate usb dt-bindings patch.
> 
> Changes in v2:
> - None
> 
>  Documentation/devicetree/bindings/usb/rockchip,dwc3.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
