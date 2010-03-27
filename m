From: baruch@tkos.co.il (Baruch Siach)
Date: Sat, 27 Mar 2010 22:57:47 +0300
Subject: [PATCH] removing compilation warning from pl061.h
In-Reply-To: <1269598090-12329-1-git-send-email-viresh.kumar@st.com>
References: <1269598090-12329-1-git-send-email-viresh.kumar@st.com>
Message-ID: <20100327195747.GA19503@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Fri, Mar 26, 2010 at 03:38:10PM +0530, Viresh KUMAR wrote:
> pl061.h is using u8 type. including <linux/types.h> in pl061.h to avoid
> warning.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>

baruch

> ---
>  include/linux/amba/pl061.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/amba/pl061.h b/include/linux/amba/pl061.h
> index b4fbd98..5ddd9ad 100644
> --- a/include/linux/amba/pl061.h
> +++ b/include/linux/amba/pl061.h
> @@ -1,3 +1,5 @@
> +#include <linux/types.h>
> +
>  /* platform data for the PL061 GPIO driver */
>  
>  struct pl061_platform_data {

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
