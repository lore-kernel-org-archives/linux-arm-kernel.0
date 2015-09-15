From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 15 Sep 2015 19:20:08 +0800
Subject: [PATCH] arm64: enable generic idle loop
In-Reply-To: <20150821155425.GC16410@e104818-lin.cambridge.arm.com>
References: <1440128422-4170-1-git-send-email-leo.yan@linaro.org>
 <20150821090043.GA14072@e104818-lin.cambridge.arm.com>
 <20150821091446.GB4280@leoy-linaro>
 <20150821155425.GC16410@e104818-lin.cambridge.arm.com>
Message-ID: <20150915112008.GA30920@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Aug 21, 2015 at 04:54:25PM +0100, Catalin Marinas wrote:
> On Fri, Aug 21, 2015 at 05:14:46PM +0800, Leo Yan wrote:
> > On Fri, Aug 21, 2015 at 10:00:43AM +0100, Catalin Marinas wrote:
> > > On Fri, Aug 21, 2015 at 11:40:22AM +0800, Leo Yan wrote:
> > > > Enable generic idle loop for ARM64, so can support for hlt/nohlt
> > > > command line options to override default idle loop behavior.
> > > 
> > > Just curious, what do you need this for?
> > 
> > With this config, usually we can add "nohlt" in command line to force
> > the cpu will never be powered off; so can quickly narrow down if some
> > issues are related with cpuidle or not.
> > 
> > And if CPU is powered off, then its debug logic also will be powered off.
> > So we can simply use this method to let debugger always hot connect with
> > the target CPU.
> 
> OK.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Suppose you have missed this patch at previous merge window,
so just for reminding.

Thanks,
Leo Yan
