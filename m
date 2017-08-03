From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Aug 2017 18:06:57 -0500
Subject: [PATCH v2 1/2] Documentation: dt: pinctrl: Add pmi8994 gpio
 support
In-Reply-To: <1501247893-30226-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1501247893-30226-1-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <20170803230657.gyufjtiirkf3hzjd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 06:48:12PM +0530, Vivek Gautam wrote:
> Update the binding doc for qcom pmi8994-gpio devices.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
> 
> - Have been testing this patch-set on db820c for extcon with
>   usb controller. The usb controller uses one of these gpios
>   for usb-id/vbus detection.
> 
> Changes since v1:
>  - Dropped "qcom,pmi8994-gpio" compatible addition to the driver
>    since we can use the generic "qcom,spmi-gpio" compatible.
>  - Sorted to add pmi8994-gpio in alphabatical order.
> 
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
