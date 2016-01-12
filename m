From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jan 2016 13:34:37 +0000
Subject: [PATCH 1/3] ARM: STi: Add DT defines for co-processor reset lines
In-Reply-To: <1445856969-19424-1-git-send-email-lee.jones@linaro.org>
References: <1445856969-19424-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20160112133437.GH27358@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 Oct 2015, Lee Jones wrote:

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  include/dt-bindings/reset-controller/stih407-resets.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/reset-controller/stih407-resets.h b/include/dt-bindings/reset-controller/stih407-resets.h
> index 02d4328..4ab3a1c 100644
> --- a/include/dt-bindings/reset-controller/stih407-resets.h
> +++ b/include/dt-bindings/reset-controller/stih407-resets.h
> @@ -52,6 +52,10 @@
>  #define STIH407_KEYSCAN_SOFTRESET	26
>  #define STIH407_USB2_PORT0_SOFTRESET	27
>  #define STIH407_USB2_PORT1_SOFTRESET	28
> +#define STIH407_ST231_AUD_SOFTRESET	29
> +#define STIH407_ST231_DMU_SOFTRESET	30
> +#define STIH407_ST231_GP0_SOFTRESET	31
> +#define STIH407_ST231_GP1_SOFTRESET	32
>  
>  /* Picophy reset defines */
>  #define STIH407_PICOPHY0_RESET		0

Has anyone seen this patch?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
