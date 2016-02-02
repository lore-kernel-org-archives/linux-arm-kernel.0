From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 1 Feb 2016 17:09:39 -0800
Subject: [PATCH v2] clk: move the common clock's to_clk_*(_hw) macros to
 clk-provider.h
In-Reply-To: <704f6d5aa50acc4723f6756c217a865641d927fe.1452267334.git.geliangtang@163.com>
References: <568F9960.9040209@gmail.com>
 <704f6d5aa50acc4723f6756c217a865641d927fe.1452267334.git.geliangtang@163.com>
Message-ID: <20160202010939.GF4848@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08, Geliang Tang wrote:
> to_clk_*(_hw) macros have been repeatedly defined in many places.
> This patch moves all the to_clk_*(_hw) definitions in the common
> clock framework to public header clk-provider.h, and drop the local
> definitions.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
