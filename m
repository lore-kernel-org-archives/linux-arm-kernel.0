From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 Dec 2017 14:57:15 -0800
Subject: [PATCH v1 3/4] clk: iproc: Allow plls to do minor rate changes
 without reset
In-Reply-To: <1502737241-2040-4-git-send-email-lori.hikichi@broadcom.com>
References: <1502737241-2040-1-git-send-email-lori.hikichi@broadcom.com>
 <1502737241-2040-4-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <20171228225715.GV7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14, Lori Hikichi wrote:
> From: Lori Hikichi <lhikichi@broadcom.com>
> 
> The iproc plls are capable of doing small rate changes without the
> need for a full reset and re-lock procedure.  This feature will
> allow for small tweaks to the PLL rate to occur smoothly.
> 
> Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
