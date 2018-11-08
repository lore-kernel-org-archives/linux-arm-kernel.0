From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 8 Nov 2018 10:11:12 +0800
Subject: [PATCH v3 1/4] dt-bindings: pinctrl: Add devicetree bindings
 for MT6797 SoC Pinctrl
In-Reply-To: <20181107174844.5381-2-manivannan.sadhasivam@linaro.org>
References: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
 <20181107174844.5381-2-manivannan.sadhasivam@linaro.org>
Message-ID: <1541643072.23791.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-11-07 at 23:18 +0530, Manivannan Sadhasivam wrote:
> Add devicetree bindings for Mediatek MT6797 SoC Pin Controller.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/pinctrl/pinctrl-mt6797.txt       |   83 +
>  include/dt-bindings/pinctrl/mt6797-pinfunc.h  | 1368 +++++++++++++++++
>  2 files changed, 1451 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt
>  create mode 100644 include/dt-bindings/pinctrl/mt6797-pinfunc.h
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt
> new file mode 100644
> index 000000000000..bd83401e6179
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt

Sorry if this is discussed.

What's the difference between this and
Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt?
Should this be added to pinctrl-mt65xx.txt?

Joe.C
