From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 1 Sep 2017 10:16:33 +0800
Subject: [PATCH 1/2] clk: hi6220: change watchdog clock source
In-Reply-To: <20170901013240.GM21656@codeaurora.org>
References: <1503993518-24428-1-git-send-email-leo.yan@linaro.org>
 <20170901013240.GM21656@codeaurora.org>
Message-ID: <20170901021633.GC516@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 06:32:40PM -0700, Stephen Boyd wrote:
> On 08/29, Leo Yan wrote:
> > The old code uses tcxo (19.2MHz) as watchdog clock but actually the
> > watchdog uses 32K clock, as result the watchdog timeout cannot be set
> > correctly and delay long time to reset SoC.
> > 
> > So this patch is to use 'ref32k' as clock source for watchdog.
> > 
> > Fixes: 72ea48610d43 ("clk: hi6220: Clock driver support for Hisilicon hi6220 SoC")
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> 
> Applied to clk-next

Thanks, Stephen.

> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
