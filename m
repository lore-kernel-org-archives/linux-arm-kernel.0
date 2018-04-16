From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Apr 2018 13:23:06 +0100
Subject: [PATCH v3 1/6] dt-bindings: mfd: stm32-timers: add support for
 dmas
In-Reply-To: <1522404084-24903-2-git-send-email-fabrice.gasnier@st.com>
References: <1522404084-24903-1-git-send-email-fabrice.gasnier@st.com>
 <1522404084-24903-2-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180416122306.qfp5rf7khexabydm@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Mar 2018, Fabrice Gasnier wrote:

> Add support for DMAs to STM32 timers. STM32 Timers can support up to 7
> dma requests: up to 4 channels, update, compare and trigger.
> DMAs may be used to transfer data from pwm capture for instance.
> DMA support is made optional, PWM capture support is also an option.
> This is much more wise system-wide to avoid shortage on DMA request
> lines as there's significant amount of timer instances that can
> request up to 7 channels.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
>  .../devicetree/bindings/mfd/stm32-timers.txt         | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
