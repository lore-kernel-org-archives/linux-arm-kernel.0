From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Apr 2016 18:14:36 -0700
Subject: [PATCH] clk: sunxi: Add CSI (camera's Sensors Interface) module
 clock driver for sun[457]i
In-Reply-To: <20160319235905.GA16539@rob-hp-laptop>
References: <1458204222-31149-1-git-send-email-yassinjaffer@gmail.com>
 <1458204222-31149-2-git-send-email-yassinjaffer@gmail.com>
 <20160319235905.GA16539@rob-hp-laptop>
Message-ID: <20160402011436.GA18567@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19, Rob Herring wrote:
> On Thu, Mar 17, 2016 at 07:43:42PM +1100, yassinjaffer at gmail.com wrote:
> > From: Yassin Jaffer <yassinjaffer@gmail.com>
> > 
> > This patch adds a composite clock type consisting of
> > a clock gate, mux, configurable dividers, and a reset control.
> > 
> > Signed-off-by: Yassin Jaffer <yassinjaffer@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/clock/sunxi.txt |   1 +
> 
> I wish someone would just add all the sunxi clocks in one pass instead 
> of one by one.
> 
> Acked-by: Rob Herring <robh@kernel.org>

Me too!

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
