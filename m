From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 5 May 2015 22:53:39 -0700
Subject: [PATCH 6/6] dt-bindings: ARM: Mediatek: Document devicetree
 bindings for clock/reset controllers
In-Reply-To: <20150504083852.GJ4946@pengutronix.de>
References: <1429778143-2074-1-git-send-email-s.hauer@pengutronix.de>
 <1429778143-2074-7-git-send-email-s.hauer@pengutronix.de>
 <20150501012039.GG32407@codeaurora.org>
 <20150504083852.GJ4946@pengutronix.de>
Message-ID: <20150506055339.GB10871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04, Sascha Hauer wrote:
> On Thu, Apr 30, 2015 at 06:20:39PM -0700, Stephen Boyd wrote:
> > On 04/23, Sascha Hauer wrote:
> > > +The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> > > +
> > > +Example:
> > > +
> > > +apmixedsys: apmixedsys at 10209000 {
> > 
> > apmixedsys: clock-controller at 10209000 {
> > 
> > would be more standard. The same comment applies throughout this
> > patch. Otherwise it looks good to me.
> 
> For apmixed this I agree, but the others are also reset controllers, so
> I'm not sure if clock-controller is appropriate. Personally I don't care
> much, I'll change to whatever you like.

I've already applied the patch, so if you like you can send a
follow up. Perhaps power-controller is more appropriate? I'm not
too worried about it though.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
