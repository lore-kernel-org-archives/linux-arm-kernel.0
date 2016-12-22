From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Dec 2016 16:14:56 -0800
Subject: [PATCHv2 2/3] clk: mvebu: adjust clock handling for the CP110
 system controller
In-Reply-To: <1482316017-22154-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482316017-22154-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482316017-22154-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20161222001456.GX8288@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21, Thomas Petazzoni wrote:
> This commit:
> 
>  - makes the GOP_DP (bit 9) gatable clock a child clock of the
>    SD_MMC_GOP (bit 18) clock, as it should have been. The clock for bit
>    18 was just named SD_MMC, but since it also covers the GOP block, it
>    is renamed SD_MMC_GOP.
> 
>  - makes the MG (bit 5) gatable clock a child clock of the MG_CORE
>    clock (bit 6)
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
