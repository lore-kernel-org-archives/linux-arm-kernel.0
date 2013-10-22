From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Oct 2013 10:07:23 +0100
Subject: [PATCH v2 1/1] mfd: syscon: return -ENOSYS if CONFIG_MFD_SYSCON
 is not enabled
In-Reply-To: <1382431585-26649-1-git-send-email-peter.chen@freescale.com>
References: <1382431585-26649-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20131022090723.GF19112@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Oct 2013, Peter Chen wrote:

> Some platforms may not define CONFIG_MFD_SYSCON (or haven't syscon),
> it can fix build error for these platforms.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> 
> ---
> 
> Changes for v2:
> - Using #ifdef instead of IS_ENABLED
> - Using ENOSYS instead of ENXIO as return val
> 
>  include/linux/mfd/syscon.h |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
