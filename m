From: agross@codeaurora.org (Andy Gross)
Date: Mon, 24 Aug 2015 14:36:14 -0500
Subject: [PATCH 11/18] ARM: qcom: use const and __initconst for
 smp_operations
In-Reply-To: <1440390978-22796-12-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
 <1440390978-22796-12-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20150824193614.GA16922@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 01:36:11PM +0900, Masahiro Yamada wrote:
> The smp_operations structure is not over-written, so add const
> qualifier and replace __initdata with __initconst.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Thanks!

Reviewed-by: Andy Gross <agross@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
