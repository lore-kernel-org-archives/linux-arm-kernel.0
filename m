From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 9 Jan 2017 16:27:30 -0800
Subject: [PATCH] clk: uniphier: remove unneeded #include <linux/delay.h>
In-Reply-To: <1482719673-17573-1-git-send-email-yamada.masahiro@socionext.com>
References: <1482719673-17573-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170110002730.GK17126@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/26, Masahiro Yamada wrote:
> This include was needed to suppress build error when this driver
> was initially merged because <linux/regmap.h> did not include
> <linux/delay.h> at that time.  (developers' headache across
> sub-systems)
> 
> The root cause has been fixed by commit adf08d481b52 ("regmap:
> include <linux/delay.h> from include/linux/regmap.h"), so this
> line can be dropped now.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
