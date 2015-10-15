From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 15 Oct 2015 12:54:56 -0700
Subject: [PATCH V3 5/6] clk: qoriq: Add ls1043a support.
In-Reply-To: <1444870621.5185.223.camel@freescale.com>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
 <1444822498-16477-6-git-send-email-B48286@freescale.com>
 <20151014183113.GE26883@codeaurora.org>
 <1444870621.5185.223.camel@freescale.com>
Message-ID: <20151015195456.GT4558@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14, Scott Wood wrote:
> On Wed, 2015-10-14 at 11:31 -0700, Stephen Boyd wrote:
> > On 10/14, Zhiqiang Hou wrote:
> > > From: Hou Zhiqiang <B48286@freescale.com>
> > > 
> > > Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> > > ---
> > 
> > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > 
> 
> Could you ack my clock patchset that this depends on (if there are no 
> 
> objections)?  Mike Turquette acked the RFC version a while back, but it's 
> 
> changed a bit since then (including the new clk_get_num_parents() and 
> 
> clk_get_parent_by_index() -- I CCed Russell King on that but got no 
> 
> response), and got no response when I asked whether the ack was still good 
> 
> for v3.
> 
> 

Done. The consumer APIs look ok too, but I'd like to see if
Russell has any comments.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
