From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Sep 2017 13:26:26 -0700
Subject: [GIT PULL] Allwinner clock changes for 4.14, take 3
In-Reply-To: <20170901061706.varrjekvcuymqzx2@flea>
References: <20170824083620.b5cq4qtyr3cqtpjx@flea.lan>
 <20170831175901.GF21656@codeaurora.org>
 <20170901061706.varrjekvcuymqzx2@flea>
Message-ID: <20170901202626.GY21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01, Maxime Ripard wrote:
> Hi Stephen,
> 
> On Thu, Aug 31, 2017 at 10:59:01AM -0700, Stephen Boyd wrote:
> > On 08/24, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > Here is a quite late PR, but this also something we've been waiting
> > > for for quite some time already.
> > > 
> > > These patches convert our last users of the old clock framework to the
> > > new one. We still have some marginal users of the old clock drivers,
> > > but they shouldn't prevent the fix for the orphans clocks we hold back
> > > to work.
> > > 
> > 
> > Great. Thanks. Pulled into clk-next.
> 
> Just so you know, since we haven't heard from you about this one, we
> didn't send the DT bits. So the conversion of our DTs will happen in
> 4.15.
> 

Ok, sounds good.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
