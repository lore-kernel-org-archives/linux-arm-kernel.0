From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Feb 2017 11:33:02 -0600
Subject: [PATCH 3/8] Documentation: dt-bindings: Add STM32 pinctrl driver
 DT bindings
In-Reply-To: <1485868465-30446-4-git-send-email-alexandre.torgue@st.com>
References: <1485868465-30446-1-git-send-email-alexandre.torgue@st.com>
 <1485868465-30446-4-git-send-email-alexandre.torgue@st.com>
Message-ID: <20170201173302.3ws4ehcjqlcnf663@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 02:14:20PM +0100, Alexandre TORGUE wrote:
> Add compatible sting for stm32h743 MCU.

Also, you can drop "Documentation: " from the subject as it is 
redundant.

> 
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> index b24583a..ac8dcb7 100644
> --- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> @@ -10,6 +10,7 @@ Required properies:
>   - compatible: value should be one of the following:
>     (a) "st,stm32f429-pinctrl"
>     (b) "st,stm32f746-pinctrl"
> +   (c) "st,stm32h743-pinctrl"
>   - #address-cells: The value of this property must be 1
>   - #size-cells	: The value of this property must be 1
>   - ranges	: defines mapping between pin controller node (parent) to
> -- 
> 1.9.1
> 
