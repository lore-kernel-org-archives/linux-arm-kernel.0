From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 17 Mar 2017 23:22:24 +0800
Subject: [PATCH v3 4/5] clk: hi6220: add debug APB clock
In-Reply-To: <20170303235808.GX25384@codeaurora.org>
References: <1488520809-31670-1-git-send-email-leo.yan@linaro.org>
 <1488520809-31670-5-git-send-email-leo.yan@linaro.org>
 <20170303235808.GX25384@codeaurora.org>
Message-ID: <20170317152224.GB2020@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Mar 03, 2017 at 03:58:08PM -0800, Stephen Boyd wrote:
> On 03/03, Leo Yan wrote:
> > The debug APB clock is absent in hi6220 driver, so this patch is to add
> > support for it.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

I found this patch introduces regression on Hikey, after I enable
CPUIdle with this patch the kernel booting will hang. I committed a
new version patch:
https://patchwork.kernel.org/patch/9630931/

So please drop v3 patch and help review v4 patch. Really Sorry for
inconvinence.

Thanks,
Leo Yan
