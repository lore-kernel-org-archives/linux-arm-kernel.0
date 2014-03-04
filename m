From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 4 Mar 2014 10:26:16 +0100
Subject: [PATCH V2] ARM: dove: dt: revert PMU interrupt controller node
In-Reply-To: <20140303222406.GW1872@titan.lakedaemon.net>
References: <20140207180836.GE8533@titan.lakedaemon.net>
 <1392667236-19126-1-git-send-email-jason@lakedaemon.net>
 <20140303150215.GI21483@n2100.arm.linux.org.uk>
 <20140303173740.GC16655@lunn.ch>
 <20140303181529.GM21483@n2100.arm.linux.org.uk>
 <20140303222406.GW1872@titan.lakedaemon.net>
Message-ID: <20140304092616.GH16655@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I could have sworn this was discussed with this particular patchset, but
> I'm unable to find the conversation in my archives.  Neither during the
> patch submission process, nor the (long) pull request thread.
> 
> Perhaps it was an irc conversation?  Andrew, Sebastian, can you find a
> link?  iirc, one of the DT maintainers (Mark Rutland?) raised the same
> concern and I thought we answered that sufficiently...

Hi Jason

It was the cpufreq driver which caused the discussion. I looked at it
for a while, and then task swapped onto the kirkwood move into
mach-mvebu.

    Andrew
