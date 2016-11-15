From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 14 Nov 2016 18:40:42 -0800
Subject: [PATCH 1/3] clk: Hi6220: enable stub clock driver for ARCH_HISI
In-Reply-To: <20161112120231.GB23848@leoy-linaro>
References: <1472633417-9330-1-git-send-email-leo.yan@linaro.org>
 <1472633417-9330-2-git-send-email-leo.yan@linaro.org>
 <20160831224049.GK12510@codeaurora.org>
 <20161112120231.GB23848@leoy-linaro>
Message-ID: <20161115024042.GV5177@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12, Leo Yan wrote:
> Hi Stephen,
> 
> On Wed, Aug 31, 2016 at 03:40:49PM -0700, Stephen Boyd wrote:
> > On 08/31, Leo Yan wrote:
> > > In current kernel config 'CONFIG_STUB_CLK_HI6220' is disabled by
> > > default, as result stub clock driver has not been registered and
> > > CPUFreq driver cannot work.
> > > 
> > > This patch is to enable stub clock driver in config for ARCH_HISI.
> > > 
> > > Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > 
> > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> We found this patch is missed mainline kernel. So could you help pick
> it? Or do you need me resend this patch?
> 

Sure I can fish it out and apply it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
