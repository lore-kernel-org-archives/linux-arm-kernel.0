From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Feb 2014 09:26:56 +0000
Subject: [PATCH] mfd: vexpress-sysreg: initialize "site" variable
In-Reply-To: <1392309594-28229-1-git-send-email-semen.protsenko@linaro.org>
References: <1392309594-28229-1-git-send-email-semen.protsenko@linaro.org>
Message-ID: <20140214092656.GH3403@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> "site" variable should be initialized with 0 so that
> when "site" property doesn't exist in DTB it can be handled correctly.
> 
> "0" value means board site number is motherboard (see
> Documentation/devicetree/bindings/arm/vexpress.txt for details).
> 
> Signed-off-by: Semen Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/mfd/vexpress-sysreg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
