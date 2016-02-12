From: adrian.hunter@intel.com (Adrian Hunter)
Date: Fri, 12 Feb 2016 11:18:01 +0200
Subject: [PATCH] MAINTAINERS: mmc: Add Adrian Hunter as the maintainer for
 SDHCI
In-Reply-To: <1455200099-5306-1-git-send-email-ulf.hansson@linaro.org>
References: <1455200099-5306-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <56BDA349.1040009@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/16 16:14, Ulf Hansson wrote:
>>From discussions on linux-mmc I have been encouraging someone to pick
> up the maintainer role for SDHCI. I am very pleased that Adrian Hunter
> volunteered and accepted the challenge!
> 
> The SDHCI code is currently in quite poor quality, but we have agreed on
> a way forward to try to reach a point where the SDHCI core becomes more of
> a set of library functions. Each SDHCI driver variant can then decide
> which functions to use and allows it to implement variant specific code,
> without needing to also change SDHCI core code.
> 
> In the end we aim to get better optimized and maintainable code.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  MAINTAINERS | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 30aca4a..5511069 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9706,10 +9706,11 @@ S:	Maintained
>  F:	drivers/mmc/host/sdricoh_cs.c
>  
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
> +M:	Adrian Hunter <adrian.hunter@intel.com>
>  L:	linux-mmc at vger.kernel.org
> -S:	Orphan
> -F:	drivers/mmc/host/sdhci.*
> -F:	drivers/mmc/host/sdhci-pltfm.[ch]
> +S:	Maintained

+T: git git://git.infradead.org/users/ahunter/linux-sdhci.git

> +F:	drivers/mmc/host/sdhci*
> +F:	include/linux/mmc/sdhci*
>  
>  SECURE COMPUTING
>  M:	Kees Cook <keescook@chromium.org>
> 

Sorry, I hadn't got round to doing this myself.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
