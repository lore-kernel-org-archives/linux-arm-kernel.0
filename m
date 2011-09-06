From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2011 12:03:11 +0100
Subject: [PATCH 1/5] ARM: Samsung: PWM: Allow to differentiate SoCs
	based on platform device name.
In-Reply-To: <1660939.8M3FnZsmga@flatron>
References: <1731819.jJi37IsjvJ@flatron>
	<CAH9JG2UiuaCyOk24hC=240ptQa8CKCVkXHaQzNt=YcnyQksnOA@mail.gmail.com>
	<1645899.rJz3R6pebo@flatron> <1660939.8M3FnZsmga@flatron>
Message-ID: <20110906110311.GM6619@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 12:41:07PM +0200, Tomasz Figa wrote:
> On Thursday 01 of September 2011 at 13:18:32, Tomasz Figa wrote:
> > Well, now we have three alternatives:
> > - to leave it as is (i.e. changing platform device names)
> > - to use cpu_is_* (does it ever exist for S3C64xx or soc_is_s3c64xx is its equivalent?)
> > - to use soc_is_* 
> > 
> > Waiting for more comments then.
> > 
> Ping.
> 
> Should I keep it as is or rather change it to use soc_is_s3c64xx instead?

I don't know what question you're asking (the questions don't make sense
in terms of the quoted context.)

If you're asking whether you should use a cpu_ prefix instead of a soc_
prefix for identifying s3c64xx, then consider the question.

What is the CPU?

What are S3C64xx / OMAP / PXA310 / SA-11x0 / AT91RM9200?  CPU or SoC ?
What are Cortex A8/A9 / Xscale / StrongARM / ARM920?  CPU or SoC ?
