From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 14 Sep 2015 14:59:23 -0700
Subject: [PATCH 5/5] clk: sunxi: sun9i-mmc: Fix module autoload for OF
 platform driver
In-Reply-To: <20150828124432.GA26670@goodgumbo.baconseed.org>
References: <20150828124432.GA26670@goodgumbo.baconseed.org>
Message-ID: <20150914215923.GG23081@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
