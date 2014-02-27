From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 27 Feb 2014 08:35:34 +0000
Subject: [PATCH v4 5/8] mfd: pm8921: Use ssbi regmap
In-Reply-To: <1393441166-32692-6-git-send-email-sboyd@codeaurora.org>
References: <1393441166-32692-1-git-send-email-sboyd@codeaurora.org>
 <1393441166-32692-6-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140227083534.GY9195@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Feb 2014, Stephen Boyd wrote:

> Use a regmap so that the pm8xxx read/write APIs can be removed
> once all consumer drivers are converted.
> 
> Reviewed-by: Mark Brown <broonie@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mfd/Kconfig       |  1 +
>  drivers/mfd/pm8921-core.c | 66 +++++++++++++++++++++++++++--------------------
>  2 files changed, 39 insertions(+), 28 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
