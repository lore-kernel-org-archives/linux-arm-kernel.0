From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 29 Apr 2014 00:24:20 -0700
Subject: [PATCH 0/2] Clock unregistration fixes
In-Reply-To: <1397863783-10728-1-git-send-email-sboyd@codeaurora.org>
References: <1397863783-10728-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140429072420.4468.87933@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2014-04-18 16:29:41)
> Two fixes for fallout from commit fcb0ee6a3d33 (clk: Implement clk_unregister).
> 
> Stephen Boyd (2):
>   clk: Fix double free due to devm_clk_register()
>   clk: Fix slab corruption in clk_unregister()

Thanks for the fixes. I've Cc'd them to stable as well for 3.14.

Regards,
Mike

> 
>  drivers/clk/clk.c | 74 ++++++++++++++++++++++++-------------------------------
>  1 file changed, 32 insertions(+), 42 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
