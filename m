From: pramod.gurav@smartplayin.com (Pramod Gurav)
Date: Sat, 27 Sep 2014 13:52:57 +0530
Subject: [PATCH v7 4/7] qcom: pm: Add cpu low power mode functions
In-Reply-To: <1411779495-39724-5-git-send-email-lina.iyer@linaro.org>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
 <1411779495-39724-5-git-send-email-lina.iyer@linaro.org>
Message-ID: <542673E1.60108@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27-09-2014 06:28 AM, Lina Iyer wrote:
> Based on work by many authors, available at codeaurora.org
> 
> Add interface layer to abstract and handle hardware specific
> functionality for executing various cpu low power modes in QCOM
> chipsets.
> 

..

> +#include <soc/qcom/scm-boot.h>
> +#include <soc/qcom/spm.h>
> +
> +#define SCM_CMD_TERMINATE_PC	(0x2)
> +#define SCM_FLUSH_FLAG_MASK	(0x3)
> +#define SCM_L2_ON 		(0x0)
There is checkpatch warning here.

WARNING: please, no space before tabs
#75: FILE: drivers/soc/qcom/pm.c:28:
+#define SCM_L2_ON ^I^I(0x0)$

> +#define SCM_L2_OFF		(0x1)
> +
> +
..

> +
> +#endif  /* __QCOM_PM_H */
> 
