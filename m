From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 6 Dec 2017 22:41:12 -0800
Subject: [PATCH 5/6] clk: h8s2678: pr_err() strings should end with
 newlines
In-Reply-To: <1f71746f971b6969882e2d7827334b416178d898.1511505932.git.arvind.yadav.cs@gmail.com>
References: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
 <1f71746f971b6969882e2d7827334b416178d898.1511505932.git.arvind.yadav.cs@gmail.com>
Message-ID: <20171207064112.GT4283@codeaurora.org>
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
