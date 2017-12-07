From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 6 Dec 2017 22:41:15 -0800
Subject: [PATCH 6/6] clk: h8300: pr_err() strings should end with newlines
In-Reply-To: <5fe05a034e646f03e6129c7782e38e37856f80a1.1511505932.git.arvind.yadav.cs@gmail.com>
References: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
 <5fe05a034e646f03e6129c7782e38e37856f80a1.1511505932.git.arvind.yadav.cs@gmail.com>
Message-ID: <20171207064115.GU4283@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24, Arvind Yadav wrote:
> pr_err() messages should end with a new-line to avoid other messages
> being concatenated.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
