From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Mar 2014 14:01:36 +0000
Subject: [PATCH V2] ARM: dove: dt: revert PMU interrupt controller node
In-Reply-To: <20140304135452.GK16655@lunn.ch>
References: <1392667236-19126-1-git-send-email-jason@lakedaemon.net>
 <20140303150215.GI21483@n2100.arm.linux.org.uk>
 <20140303173740.GC16655@lunn.ch>
 <20140303181529.GM21483@n2100.arm.linux.org.uk>
 <20140303222406.GW1872@titan.lakedaemon.net> <20140304092616.GH16655@lunn.ch>
 <5315AD6F.1070804@gmail.com> <20140304121136.GR21483@n2100.arm.linux.org.uk>
 <20140304135306.GL1872@titan.lakedaemon.net> <20140304135452.GK16655@lunn.ch>
Message-ID: <20140304140135.GS21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 02:54:52PM +0100, Andrew Lunn wrote:
> > > So we have cpufreq, pm domains and an irq controller.  What's the plan
> > > for this, who's going to look at sorting this out?
> > 
> > Andrew, Sebastian?  I'm currently task-saturated...
> 
> I doubt i will be doing anything with it for the remainder of this
> cycle. I would like to finish converting kirkwood to DT before
> starting on anything new.

Okay, can someone send me the cpufreq code then please?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
