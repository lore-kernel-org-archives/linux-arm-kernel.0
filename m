From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 26 Mar 2015 22:46:34 -0700
Subject: [PATCH] clk: qcom: Fix ipq806x LCC frequency tables
In-Reply-To: <20150303001024.GA31275@kwestfie-linux.qualcomm.com>
References: <1425008264-18875-1-git-send-email-sboyd@codeaurora.org>
 <20150303001024.GA31275@kwestfie-linux.qualcomm.com>
Message-ID: <20150327054634.GA5625@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02, Kenneth Westfield wrote:
> On Thu, Feb 26, 2015 at 07:37:44PM -0800, Stephen Boyd wrote:
> > These frequency tables list the wrong rates. Either they don't
> > have the correct frequency at all, or they're specified in kHz
> > instead of Hz. Fix it.
> > 
> > Fixes: c99e515a92e9 "clk: qcom: Add IPQ806X LPASS clock controller (LCC) driver"
> > Cc: Kenneth Westfield <kwestfie@codeaurora.org>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  drivers/clk/qcom/lcc-ipq806x.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> Verified audio functionality on the Storm board (w/o SPDIF).
> 
> Tested-by: Kenneth Westfield <kwestfie@codeaurora.org>
> 

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
