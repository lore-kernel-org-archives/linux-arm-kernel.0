From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 27 Feb 2014 08:35:57 +0000
Subject: [PATCH v4 6/8] mfd: pm8921: Add DT match table
In-Reply-To: <1393441166-32692-7-git-send-email-sboyd@codeaurora.org>
References: <1393441166-32692-1-git-send-email-sboyd@codeaurora.org>
 <1393441166-32692-7-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140227083557.GZ9195@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Feb 2014, Stephen Boyd wrote:

> Allow this driver to probe based on devicetree.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mfd/pm8921-core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
