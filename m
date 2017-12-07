From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 6 Dec 2017 22:41:07 -0800
Subject: [PATCH 4/6] SPEAr: clk: pr_err() strings should end with newlines
In-Reply-To: <35a712ed8ee10491c0a605d0cc825250286370a4.1511505932.git.arvind.yadav.cs@gmail.com>
References: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
 <35a712ed8ee10491c0a605d0cc825250286370a4.1511505932.git.arvind.yadav.cs@gmail.com>
Message-ID: <20171207064107.GS4283@codeaurora.org>
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
