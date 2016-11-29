From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 29 Nov 2016 13:12:16 -0800
Subject: [PATCH v2 1/3] clk: uniphier: remove unneeded member name for
 union
In-Reply-To: <1479967061-25975-1-git-send-email-yamada.masahiro@socionext.com>
References: <1479967061-25975-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20161129211216.GE6095@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24, Masahiro Yamada wrote:
> The struct member name of a union is unneeded.  This makes the code
> a bit shorter.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
