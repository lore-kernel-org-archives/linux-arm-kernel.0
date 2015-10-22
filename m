From: agross@codeaurora.org (Andy Gross)
Date: Wed, 21 Oct 2015 21:50:49 -0500
Subject: [PATCH] serial: msm_serial: Make config tristate
In-Reply-To: <1445468723-948-1-git-send-email-sboyd@codeaurora.org>
References: <1445468723-948-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20151022025049.GA4968@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 04:05:23PM -0700, Stephen Boyd wrote:
> This driver works as a module, so mark it as a tristate config
> instead of a bool.
> 
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> I tested this with a busybox ramdisk that modprobes msm_serial and
> then runs a getty on ttyMSM0. This patch should supersede Paul's earlier
> patch that removes the module code from this driver.
> 
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Andy Gross <agross@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
