From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 4 Mar 2014 14:54:52 +0100
Subject: [PATCH V2] ARM: dove: dt: revert PMU interrupt controller node
In-Reply-To: <20140304135306.GL1872@titan.lakedaemon.net>
References: <20140207180836.GE8533@titan.lakedaemon.net>
 <1392667236-19126-1-git-send-email-jason@lakedaemon.net>
 <20140303150215.GI21483@n2100.arm.linux.org.uk>
 <20140303173740.GC16655@lunn.ch>
 <20140303181529.GM21483@n2100.arm.linux.org.uk>
 <20140303222406.GW1872@titan.lakedaemon.net>
 <20140304092616.GH16655@lunn.ch> <5315AD6F.1070804@gmail.com>
 <20140304121136.GR21483@n2100.arm.linux.org.uk>
 <20140304135306.GL1872@titan.lakedaemon.net>
Message-ID: <20140304135452.GK16655@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > So we have cpufreq, pm domains and an irq controller.  What's the plan
> > for this, who's going to look at sorting this out?
> 
> Andrew, Sebastian?  I'm currently task-saturated...

I doubt i will be doing anything with it for the remainder of this
cycle. I would like to finish converting kirkwood to DT before
starting on anything new.

	 Andrew
