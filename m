From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 23 Sep 2016 14:44:50 -0700
Subject: [PATCH v3 2/3] clk: mvebu: dynamically allocate resources in
 Armada CP110 system controller
In-Reply-To: <1474448759-24482-3-git-send-email-mw@semihalf.com>
References: <1474448759-24482-1-git-send-email-mw@semihalf.com>
 <1474448759-24482-3-git-send-email-mw@semihalf.com>
Message-ID: <20160923214450.GE21232@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21, Marcin Wojtas wrote:
> Original commit, which added support for Armada CP110 system controller
> used global variables for storing all clock information. It worked
> fine for Armada 7k SoC, with single CP110 block. After dual-CP110 Armada 8k
> was introduced, the data got overwritten and corrupted.
> 
> This patch fixes the issue by allocating resources dynamically in the
> driver probe and storing it as platform drvdata.
> 
> Fixes: d3da3eaef7f4 ("clk: mvebu: new driver for Armada CP110 system ...")
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> CC: <stable@vger.kernel.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
