From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 12 Jun 2014 10:19:32 +0100
Subject: [PATCH v4 3/6] drivers: cpuidle: implement OF based idle states
 infrastructure
In-Reply-To: <alpine.LFD.2.11.1406111431080.25775@knanqh.ubzr>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1406111431080.25775@knanqh.ubzr>
Message-ID: <20140612091932.GC29295@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 07:38:51PM +0100, Nicolas Pitre wrote:
> On Wed, 11 Jun 2014, Lorenzo Pieralisi wrote:
> 
> > On most common ARM systems, the low-power states a CPU can be put into are
> > not discoverable in HW and require device tree bindings to describe
> > power down suspend operations and idle states parameters.
> > 
> > In order to enable DT based idle states and configure idle drivers, this
> > patch implements the bulk infrastructure required to parse the device tree
> > idle states bindings and initialize the corresponding CPUidle driver states
> > data.
> 
> Oh and another pet peeve of mine: given we always talk about "device 
> tree" all the time, could you s/OF/DT/ in the subject?  It's been a 
> while that DT has outgrown its OF origins.

> >  create mode 100644 drivers/cpuidle/of_idle_states.c
> >  create mode 100644 drivers/cpuidle/of_idle_states.h
> 
> Ditto here, including any new symbols you introduced.

Yes you have a point, I will do.

Thanks,
Lorenzo
