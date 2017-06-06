From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 6 Jun 2017 10:02:45 +0200
Subject: [PATCH v3 4/6] dt-bindings: display: stm32: remove
 st-display-subsystem parent node requirement
In-Reply-To: <1496414235-20098-5-git-send-email-philippe.cornu@st.com>
References: <1496414235-20098-1-git-send-email-philippe.cornu@st.com>
 <1496414235-20098-5-git-send-email-philippe.cornu@st.com>
Message-ID: <0e3438c7-2a8d-fda8-ef07-017ddd881955@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

On 06/02/2017 04:37 PM, Philippe CORNU wrote:
> There is no need anymore to have a "st-display-subsystem" parent node
> in the device tree for the ltdc.
> 
> Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
> ---
>  Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> index 8e14769..90a8459 100644
> --- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> +++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> @@ -1,7 +1,6 @@
>  * STMicroelectronics STM32 lcd-tft display controller
>  
>  - ltdc: lcd-tft display controller host
> -  must be a sub-node of st-display-subsystem

Please fix alignment here.

>    Required properties:
>    - compatible: "st,stm32-ltdc"
>    - reg: Physical base address of the IP registers and length of memory mapped region.
> 

Apart from that :
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
