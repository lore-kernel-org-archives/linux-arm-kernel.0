From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 01 Apr 2015 11:09:46 -0700
Subject: [PATCH V2 linux-next] clk: constify of_device_id array
In-Reply-To: <1427827843-30823-1-git-send-email-fabf@skynet.be>
References: <1427827843-30823-1-git-send-email-fabf@skynet.be>
Message-ID: <551C346A.9040905@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/15 11:50, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>
> __initdata updated to __initconst for
> static const struct of_device_id ti_clkdm_match_table[]
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
>

Thanks. Applied to clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
