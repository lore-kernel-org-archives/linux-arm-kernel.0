From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 17 Jul 2017 19:34:08 +0100
Subject: [PATCH v3 1/9] dt-bindings: mfd: Add STM32 LPTimer binding
In-Reply-To: <1499445068-7037-2-git-send-email-fabrice.gasnier@st.com>
References: <1499445068-7037-1-git-send-email-fabrice.gasnier@st.com>
 <1499445068-7037-2-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170717183408.rk2lutdcvwl4gn4v@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 07 Jul 2017, Fabrice Gasnier wrote:

> Add documentation for STMicroelectronics STM32 Low-Power Timer binding.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
> Changes in v3:
> - Rob's comment on node name: timer at ...
> 
> Changes in v2:
> - Lee's comments: s/Low Power/Low-Power/, remove 0x in example, improve
>   properties descriptions
> ---
>  .../devicetree/bindings/mfd/stm32-lptimer.txt      | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
