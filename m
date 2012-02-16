From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 16 Feb 2012 16:30:59 +0530
Subject: [PATCH] amba/serial.h: Include types.h for resolving dependency
 of type bool
In-Reply-To: <c2d85148580bc2ffa4417dac8b8383669a68d918.1325659906.git.viresh.kumar@st.com>
References: <c2d85148580bc2ffa4417dac8b8383669a68d918.1325659906.git.viresh.kumar@st.com>
Message-ID: <4F3CE1EB.8080306@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/4/2012 12:22 PM, Viresh KUMAR wrote:
> serial.h uses bool, but its definition is missing, as it doesn't include
> types.h. Fix this by including types.h
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  include/linux/amba/serial.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
> index 514ed45..d117b29 100644
> --- a/include/linux/amba/serial.h
> +++ b/include/linux/amba/serial.h
> @@ -23,6 +23,8 @@
>  #ifndef ASM_ARM_HARDWARE_SERIAL_AMBA_H
>  #define ASM_ARM_HARDWARE_SERIAL_AMBA_H
>  
> +#include <linux/types.h>
> +
>  /* -------------------------------------------------------------------------------
>   *  From AMBA UART (PL010) Block Specification
>   * -------------------------------------------------------------------------------

Any feedback?

-- 
viresh
