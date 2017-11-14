From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 13 Nov 2017 17:59:27 -0800
Subject: [PATCH 2/2] clk/ux500: Improve a size determination in three
 functions
In-Reply-To: <1991a7d3-59b8-1a5f-dcef-a0a493e3829d@users.sourceforge.net>
References: <d23a685d-f8a0-f4ca-078a-414d7b8674ca@users.sourceforge.net>
 <1991a7d3-59b8-1a5f-dcef-a0a493e3829d@users.sourceforge.net>
Message-ID: <20171114015927.GQ11955@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 27 Sep 2017 20:30:53 +0200
> 
> Replace the specification of data structures by pointer dereferences
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
