From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 15 Jun 2016 17:17:14 -0700
Subject: [PATCH 3/5] ARM: dts: add L2CC and RPM with regulators for MSM8660
In-Reply-To: <20160614224807.GE1041@n2100.armlinux.org.uk>
References: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
 <1465918259-11138-4-git-send-email-linus.walleij@linaro.org>
 <20160614185517.GG28218@codeaurora.org>
 <20160614224807.GE1041@n2100.armlinux.org.uk>
Message-ID: <20160616001714.GN28218@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14, Russell King - ARM Linux wrote:
> On Tue, Jun 14, 2016 at 11:55:17AM -0700, Stephen Boyd wrote:
> > On 06/14, Linus Walleij wrote:
> > > +
> > > +			pm8901-regulators {
> > 
> > I'd rather have regulators at 8901 and regulators at 8058. That way the
> > node name is generic per ePAPR suggestions.
> 
> But ePAPR requires reg= if you specify a unit-address part of the
> node name.
> 

It seems the ePAPR also leaves this open to interpretation
because it states:

  "The binding for a particular bus may specify additional, more
  specific requirements for the format of reg and unit-address."

but we haven't done anything formal for the RPM "bus" so far. I'm
not worried either way, just a fun fact!

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
