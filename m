From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 14 Sep 2016 17:39:33 -0700
Subject: [PATCH 02/34] clk: at91: Migrate to clk_hw based registration
 and OF APIs
In-Reply-To: <20160607184059.6c83477f@bbrezillon>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-3-stephen.boyd@linaro.org>
 <20160607163621.GN3363@piout.net>
 <20160607184059.6c83477f@bbrezillon>
Message-ID: <20160915003933.GK7243@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07, Boris Brezillon wrote:
> On Tue, 7 Jun 2016 18:36:21 +0200
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
> > On 01/06/2016 at 16:15:01 -0700, Stephen Boyd wrote :
> > > Now that we have clk_hw based provider APIs to register clks, we
> > > can get rid of struct clk pointers in this driver, allowing us to
> > > move closer to a clear split of consumer and provider clk APIs.
> > > 
> > > Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > > Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>  
> > 
> > Well, apart the same comment about alignement:
> > 
> > Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Tested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 

Ok I fixed the alignment and pushed to clk-next.
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
