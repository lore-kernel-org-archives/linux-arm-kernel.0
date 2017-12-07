From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 6 Dec 2017 22:40:38 -0800
Subject: [PATCH 1/6] clk: stm32f4: pr_err() strings should end with
 newlines
In-Reply-To: <d5b9943c076a8ad168d9b0b3ba3aec7c9b8d7d06.1511505932.git.arvind.yadav.cs@gmail.com>
References: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
 <d5b9943c076a8ad168d9b0b3ba3aec7c9b8d7d06.1511505932.git.arvind.yadav.cs@gmail.com>
Message-ID: <20171207064038.GP4283@codeaurora.org>
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
