From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 28 Apr 2014 23:17:49 -0700
Subject: [PATCH 0/3] CCF fixlets
In-Reply-To: <1395875197-16816-1-git-send-email-sboyd@codeaurora.org>
References: <1395875197-16816-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140429061749.7224.52047@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2014-03-26 16:06:34)
> Two small changes to clean up the code plus a change to make
> driver code simpler.

Take into clk-next. Thanks for the fixlets.

Regards,
Mike

> 
> Stephen Boyd (3):
>   clk: Don't check for missing ops in clk_set_parent()
>   clk: Consolidate recalc rate logic
>   clk: Ignore error and NULL pointers passed to
>     clk_{unprepare,disable}()
> 
>  drivers/clk/clk.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
