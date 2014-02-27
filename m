From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 27 Feb 2014 08:37:32 +0000
Subject: [PATCH v4 7/8] mfd: pm8921: Loosen Kconfig dependency
In-Reply-To: <1393441166-32692-8-git-send-email-sboyd@codeaurora.org>
References: <1393441166-32692-1-git-send-email-sboyd@codeaurora.org>
 <1393441166-32692-8-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140227083732.GA9195@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Feb 2014, Stephen Boyd wrote:

> Allow this driver to be compiled on all ARM builds as it doesn't
> rely on anything within arm/mach-msm.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
