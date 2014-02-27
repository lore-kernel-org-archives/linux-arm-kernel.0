From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 27 Feb 2014 08:34:38 +0000
Subject: [PATCH v4 3/8] mfd: pm8921: Migrate to irqdomains
In-Reply-To: <1393441166-32692-4-git-send-email-sboyd@codeaurora.org>
References: <1393441166-32692-1-git-send-email-sboyd@codeaurora.org>
 <1393441166-32692-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140227083438.GW9195@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Feb 2014, Stephen Boyd wrote:

> Convert this driver to use irqdomains so that the PMIC's child
> devices can be converted to devicetree.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mfd/Kconfig               |   1 +
>  drivers/mfd/pm8921-core.c         | 198 +++++++++++++++-----------------------
>  include/linux/mfd/pm8xxx/irq.h    |  36 -------
>  include/linux/mfd/pm8xxx/pm8921.h |  30 ------
>  4 files changed, 76 insertions(+), 189 deletions(-)
>  delete mode 100644 include/linux/mfd/pm8xxx/irq.h
>  delete mode 100644 include/linux/mfd/pm8xxx/pm8921.h

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
