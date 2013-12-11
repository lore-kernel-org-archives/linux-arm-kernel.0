From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 11 Dec 2013 09:55:00 +0000
Subject: [PATCH 8/8] mfd: pm8921: Use ssbi regmap
In-Reply-To: <1386718523-2587-9-git-send-email-sboyd@codeaurora.org>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
 <1386718523-2587-9-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131211095500.GJ16780@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Use a regmap so that the pm8xxx read/write APIs can be removed
> once all consumer drivers are converted.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mfd/Kconfig       |  1 +
>  drivers/mfd/pm8921-core.c | 70 +++++++++++++++++++++++++----------------------
>  2 files changed, 39 insertions(+), 32 deletions(-)

As this is regmap related, don't forget to CC Mark Brown when you
resubmit this patchset.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
