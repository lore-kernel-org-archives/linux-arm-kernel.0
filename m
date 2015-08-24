From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 24 Aug 2015 13:33:18 -0700
Subject: [PATCH 01/18] ARM: add const qualifier to the argument of
 smp_set_ops()
In-Reply-To: <1440390978-22796-2-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
 <1440390978-22796-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20150824203318.GB14330@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24, Masahiro Yamada wrote:
> This function just copies '*ops' to 'smp_ops', so the given
> structure '*ops' is not modified at all.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
