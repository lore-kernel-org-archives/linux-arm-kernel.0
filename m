From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Dec 2017 15:02:32 -0800
Subject: [PATCH V7 01/12] drivers: move clock common macros out from
 vendor directories
In-Reply-To: <20171207125715.16160-2-chunyan.zhang@spreadtrum.com>
References: <20171207125715.16160-1-chunyan.zhang@spreadtrum.com>
 <20171207125715.16160-2-chunyan.zhang@spreadtrum.com>
Message-ID: <20171221230232.GO7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07, Chunyan Zhang wrote:
> These macros are used by more than one SoC vendor platforms, avoid to
> have many copies of these code, this patch moves them to the common
> header file which every clock drivers can access to.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
