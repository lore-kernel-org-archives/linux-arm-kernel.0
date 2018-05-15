From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 15 May 2018 10:28:11 +0200
Subject: [GIT PULL] arm64: defconfig: hisilicon config updates for v4.18
In-Reply-To: <20180514201445.6sglddhalvclu36v@localhost>
References: <5AF5A94A.4080308@hisilicon.com>
 <20180514201445.6sglddhalvclu36v@localhost>
Message-ID: <20180515082811.GL29062@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 01:14:45PM -0700, Olof Johansson wrote:
> Hi Wei,
> 
> On Fri, May 11, 2018 at 03:31:38PM +0100, Wei Xu wrote:
> > Hi Arnd, Hi Olof,
> > 
> > Please help to pull the following changes.
> > 
> > About the CLOCK_STUB and the MAILBOX consolidate patch,
> > Jassi and Stephen have acked it.
> > Could you let me know how to handle this kind case
> > if it is not OK to be in this pull?
> 
> I don't think there's any need to group the Kconfig changes with the defconfig
> updates here, is there?

I don't have the patches history, but likely this patch should come together with:

https://patchwork.kernel.org/patch/10399799/
https://patchwork.kernel.org/patch/10399801/

Otherwise the compilation options won't be consistent with what is enabled in
the DT.

 
> So, the clk Kconfig change can go in through the clk maintainer (in one patch),
> the mailbox can go in through that maintainer as a separate patch. The update
> to the defconfig is just removing what's now the new default, so it's not
> urgent to do.
> 
> Based on this, can you respin the pull request with that patch dropped? Thanks!
> 
> 
> -Olof

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
