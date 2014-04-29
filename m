From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 29 Apr 2014 09:05:53 +0100
Subject: [PATCH] mfd: pm8921: Remove pm8xxx API now that sub-devices use
 regmap
In-Reply-To: <1397002455-12854-1-git-send-email-sboyd@codeaurora.org>
References: <1397002455-12854-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140429080553.GD29462@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The pm8xxx read/write wrappers are no longer necessary now that
> all the sub-device drivers are using the regmap API. Remove it.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> Based on Linus' tip as of a7963eb7f4c4 (Merge branch 'for_linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs, 2014-04-07)
> 
>  drivers/mfd/pm8921-core.c       | 123 +---------------------------------------
>  include/linux/mfd/pm8xxx/core.h |  81 --------------------------
>  2 files changed, 2 insertions(+), 202 deletions(-)
>  delete mode 100644 include/linux/mfd/pm8xxx/core.h

Sorry, this slipped through the gaps.

Diff looks great. Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
