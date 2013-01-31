From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Jan 2013 16:25:23 +0000
Subject: BogoMIPS change in 3.6+
In-Reply-To: <510A9AD8.8060003@ti.com>
References: <510A988F.6030508@gmail.com>
 <510A9AD8.8060003@ti.com>
Message-ID: <20130131162523.GE835@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 04:24:56PM +0000, Santosh Shilimkar wrote:
> On Thursday 31 January 2013 09:45 PM, Rob Herring wrote:
> > The BogoMIPS value has changed on highbank since the commit below in
> > 3.6. It is now half the value it used to be. Does that matter other than
> > perception (I've checked that I'm not running at half the freq)?
> >
> I also stumbled on this while testing Will's series.[1]
> There should be no other functional issue apart from getting surprised.

Right, but you were using the arch-timers w/ Cortex-A15. I thought Highbank
was A9?

Will
