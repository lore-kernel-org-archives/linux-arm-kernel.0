From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 Dec 2017 14:57:17 -0800
Subject: [PATCH v1 4/4] clk: iproc: Minor tidy up of iproc pll data
 structures
In-Reply-To: <1502737241-2040-5-git-send-email-lori.hikichi@broadcom.com>
References: <1502737241-2040-1-git-send-email-lori.hikichi@broadcom.com>
 <1502737241-2040-5-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <20171228225717.GW7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14, Lori Hikichi wrote:
> From: Lori Hikichi <lhikichi@broadcom.com>
> 
> There were a few fields in the iproc pll data structures that were
> holding information that was not true state information.
> Using stack variables is sufficient and simplifies the structure.
> There are not any functional changes in this commit.
> 
> Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
