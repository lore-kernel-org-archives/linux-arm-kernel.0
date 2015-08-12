From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 12 Aug 2015 01:33:36 -0700
Subject: [PATCH v4 3/4] clk: Hi6220: add stub clock driver
In-Reply-To: <1438673249-6051-4-git-send-email-leo.yan@linaro.org>
References: <1438673249-6051-1-git-send-email-leo.yan@linaro.org>
 <1438673249-6051-4-git-send-email-leo.yan@linaro.org>
Message-ID: <20150812083336.GC13623@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04, Leo Yan wrote:
> On Hi6220, there have some clocks which can use mailbox channel to send
> messages to power controller to change frequency; this includes CPU, GPU
> and DDR clocks.
> 
> For dynamic frequency scaling, firstly need write the frequency value to
> SRAM region, and then send message to mailbox to trigger power controller
> to handle this requirement. This driver will use syscon APIs to pass SRAM
> memory region and use common mailbox APIs for channels accessing.
> 
> This init driver will support cpu frequency change firstly.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
