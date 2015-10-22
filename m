From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Oct 2015 17:04:52 -0700
Subject: [PATCH v3 07/10] clk: iproc: Separate status and control variables
In-Reply-To: <1444938513-10758-8-git-send-email-jonmason@broadcom.com>
References: <1444938513-10758-1-git-send-email-jonmason@broadcom.com>
 <1444938513-10758-8-git-send-email-jonmason@broadcom.com>
Message-ID: <20151022000452.GU19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15, Jon Mason wrote:
> Some PLLs have separate registers for Status and Control.  The means the
> pll_base needs to be split into 2 new variables, so that those PLLs can
> specify device tree registers for those independently.  Also, add a new
> driver flag to identify this presence of the split, and let the driver
> know that additional registers need to be used.
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---

Applied to clk-iproc

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
