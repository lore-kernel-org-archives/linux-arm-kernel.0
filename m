From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 13 Nov 2017 17:59:22 -0800
Subject: [PATCH] clk/spear: Delete five error messages for a failed
 memory allocation
In-Reply-To: <4283fdab-7005-f774-9594-821582c5a9fb@users.sourceforge.net>
References: <4283fdab-7005-f774-9594-821582c5a9fb@users.sourceforge.net>
Message-ID: <20171114015922.GP11955@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 27 Sep 2017 18:00:21 +0200
> 
> Omit extra messages for a memory allocation failure in these functions.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
