From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 4 Sep 2017 14:46:20 +0100
Subject: [RESEND PATCH v3 2/9] mfd: Add STM32 LPTimer driver
In-Reply-To: <1503914654-19963-3-git-send-email-fabrice.gasnier@st.com>
References: <1503914654-19963-1-git-send-email-fabrice.gasnier@st.com>
 <1503914654-19963-3-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170904134620.gdabswhptjbgweqk@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Aug 2017, Fabrice Gasnier wrote:

> STM32 Low-Power Timer hardware block can be used for:
> - PWM generation
> - IIO trigger (in sync with PWM)
> - IIO quadrature encoder counter
> PWM and IIO timer configuration are mixed in the same registers so
> we need a multi fonction driver to be able to share those registers.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - Lee's remarks: various comments, max register define, s/Low Power/Low-Power,
>   clock name, removed reset, add kernel doc for stm32_lptimer struct
> ---
>  drivers/mfd/Kconfig               |  14 +++++
>  drivers/mfd/Makefile              |   1 +
>  drivers/mfd/stm32-lptimer.c       | 107 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stm32-lptimer.h |  62 ++++++++++++++++++++++
>  4 files changed, 184 insertions(+)
>  create mode 100644 drivers/mfd/stm32-lptimer.c
>  create mode 100644 include/linux/mfd/stm32-lptimer.h

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
