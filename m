From: saeed.bishara@gmail.com (saeed bishara)
Date: Sun, 2 May 2010 18:54:15 +0300
Subject: [PATCH 3/5] USB: add clk structure for systems that support
	clkdev framework
In-Reply-To: <20100502153157.GD4233@n2100.arm.linux.org.uk>
References: <1272810162-14858-1-git-send-email-saeed@marvell.com>
	<1272810162-14858-2-git-send-email-saeed@marvell.com>
	<1272810162-14858-3-git-send-email-saeed@marvell.com>
	<1272810162-14858-4-git-send-email-saeed@marvell.com>
	<20100502143602.GA4233@n2100.arm.linux.org.uk>
	<r2oc70ff3ad1005020805zc80ad8b9n1e56d4a0a6ce5b9c@mail.gmail.com>
	<20100502151425.GC4233@n2100.arm.linux.org.uk>
	<u2wc70ff3ad1005020821z5eb3eec5y5a64b1d5dd3652a@mail.gmail.com>
	<20100502153157.GD4233@n2100.arm.linux.org.uk>
Message-ID: <i2ic70ff3ad1005020854l2738ace8l3c7c291cf07c9402@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> well, I think that those drivers that have more than one clk can be
>> redesigned by adding virtual clk for the the usb host, and the clk
>> implementation for that soc should manage all the underlying physical
>> clocks. I've looked at the omap,at91 and atmel, and it looks to me
>> that this is doable. you see can see that the clk stuff in those
>> driver has nothing to do with usb itself. what do you think?
>
> Not happy with this for two reasons:
> 1. You're assuming that they can be managed as one entity; that doesn't seem
> ? true for some of the drivers.
can you please give an example?

saeed
