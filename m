From: richard.zhao@linaro.org (Richard Zhao)
Date: Sun, 13 Nov 2011 11:30:17 +0800
Subject: [PATCH 1/1] net: fec: convert to clk_prepare/clk_unprepare
In-Reply-To: <20111111.204326.828073674055146601.davem@davemloft.net>
References: <1320901304-13157-1-git-send-email-richard.zhao@linaro.org>
 <20111111.204326.828073674055146601.davem@davemloft.net>
Message-ID: <20111113033012.GB2425@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 08:43:26PM -0500, David Miller wrote:
> From: Richard Zhao <richard.zhao@linaro.org>
> Date: Thu, 10 Nov 2011 13:01:44 +0800
> 
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> 
> You're going to have to provide a more reasonable commit message.
> 
> Unless it's a typo fix or similar you need to explain your change
> and why it's necessary.

It's for migrating to generic clock framework.
Is it ok if I add above to commit message?

Richard
