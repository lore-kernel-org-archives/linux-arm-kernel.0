From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 19 Apr 2017 10:18:35 -0700
Subject: [PATCH 0/2] clk: mediatek: add missing ethernet reset definition
In-Reply-To: <6803ef87-fb22-075c-bee1-3c0adb8e297d@phrozen.org>
References: <1485175707-58528-1-git-send-email-john@phrozen.org>
 <20170127001441.GS8801@codeaurora.org>
 <6803ef87-fb22-075c-bee1-3c0adb8e297d@phrozen.org>
Message-ID: <20170419171835.GO7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27, John Crispin wrote:
> 
> 
> On 27/01/2017 01:14, Stephen Boyd wrote:
> > On 01/23, John Crispin wrote:
> >> When the clk code for mt2701 was merged, we forgot to add the reset
> >> controller of the ethernet subsystem. This series adds the missing code
> >> and header files required to reference the bits from within a devicetree
> >> file.
> >>
> >> John Crispin (2):
> >>   clk: mediatek: add mt2701 ethernet reset
> >>   reset: mediatek: Add MT2701 ethsys reset controller include file
> >>
> >>  drivers/clk/mediatek/clk-mt2701-eth.c     |    2 ++
> >>  include/dt-bindings/reset/mt2701-resets.h |    7 +++++++
> > 
> > Any planned DT users in the next merge window? Should I put this
> > into a topic branch? Do you want a clk maintainer ack? At the
> > least we need someone like James to ack this first.
> > 
> 
> Hi Stephen,
> 
> the addition of the dtsi snippets for the ethernet core is pending due
> to this patch. getting it into v4.11 would be geat so that i can sent
> dtsi changes during the next merge window.
> 

Sorry, I never saw anything from anyone @mediatek so I never did
anything here. I suppose I'll just go and apply this to clk-next
now and then v4.13 can get the ethernet patches?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
