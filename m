From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 11 Dec 2013 09:53:49 +0000
Subject: [PATCH 7/8] mfd: pm8921: Migrate to irqdomains
In-Reply-To: <1386718523-2587-8-git-send-email-sboyd@codeaurora.org>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
 <1386718523-2587-8-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131211095349.GI16780@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Convert this driver to use irqdomains so that the PMIC's child
> devices can be converted to devicetree.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mfd/pm8921-core.c         | 186 ++++++++++++++------------------------
>  include/linux/mfd/pm8xxx/irq.h    |  59 ------------
>  include/linux/mfd/pm8xxx/pm8921.h |  30 ------
>  3 files changed, 66 insertions(+), 209 deletions(-)
>  delete mode 100644 include/linux/mfd/pm8xxx/irq.h
>  delete mode 100644 include/linux/mfd/pm8xxx/pm8921.h

I'd like to review this patch by applying it, which I can't do until
patch 5 has been fixed. Please resubmit once it's been rectified.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
