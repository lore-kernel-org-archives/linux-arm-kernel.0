From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 11 Aug 2015 17:27:15 -0700
Subject: [PATCH 3/7 v2] clk: atlas7: fix integer overflow in dto rate
 calculation
In-Reply-To: <1438699532-13860-4-git-send-email-21cnbao@gmail.com>
References: <1438699532-13860-1-git-send-email-21cnbao@gmail.com>
 <1438699532-13860-4-git-send-email-21cnbao@gmail.com>
Message-ID: <20150812002715.GE26614@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04, Barry Song wrote:
> From: Yibo Cai <yibo.cai@csr.com>
> 
> I cannot believe that I spend quite a lot time in finding this bug.
> It seems a pitfall people tend to fall in.
> 
> In "int64 = int32 * int32", conversion from 32-bits to 64-bits comes
> after the multiplication. So this statement may not work as expected.
> 
> Signed-off-by: Yibo Cai <yibo.cai@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
