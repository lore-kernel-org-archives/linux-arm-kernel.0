From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 7 Jun 2016 16:07:58 -0700
Subject: [PATCH] tty: serial: msm: fix definition of msm_stop_dma
In-Reply-To: <1465323112-32366-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465323112-32366-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160607230758.GZ28218@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07, Ben Dooks wrote:
> The msm_stop_dma() is not exported from the driver, so make
> it static to stop the following warning:
> 
> drivers/tty/serial/msm_serial.c:84:6: warning: symbol 'msm_stop_dma' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
