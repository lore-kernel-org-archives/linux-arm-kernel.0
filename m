From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Nov 2017 10:04:34 -0800
Subject: [PATCH] clk: uniphier: fix parent of miodmac clock data
In-Reply-To: <1508374366-27171-1-git-send-email-yamada.masahiro@socionext.com>
References: <1508374366-27171-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20171114180434.GA11955@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19, Masahiro Yamada wrote:
> The "miodmac" is not a child of "stdmac".  They are independent
> from each other.  Fix it.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
