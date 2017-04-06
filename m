From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 6 Apr 2017 21:59:13 +0800
Subject: [PATCH v5 7/9] clk: hi6220: add debug APB clock
In-Reply-To: <20170404215109.GH18246@codeaurora.org>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
 <1490466197-29163-8-git-send-email-leo.yan@linaro.org>
 <20170404215109.GH18246@codeaurora.org>
Message-ID: <20170406135913.GA25216@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 02:51:09PM -0700, Stephen Boyd wrote:
> On 03/26, Leo Yan wrote:
> > The debug APB clock is absent in hi6220 driver, so this patch is to add
> > support for it.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> 
> Applied to clk-next.

Thanks a lot :)

> I suspect we don't need a topic branch for
> the DT header because arm-soc won't be taking the dts side of the
> changes?

I think this question is leaving for maintainers.

Thanks,
Leo Yan
