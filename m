From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Apr 2015 15:48:24 +0100
Subject: [PATCH] ARM: mvebu: use 0xf1000000 as internal registers on
 Armada 370 DB
In-Reply-To: <20150402161626.182e267d@free-electrons.com>
References: <1427966184-8288-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <2321040.CmsL1gluUd@wuerfel>
 <20150402153650.2cc9c3d7@free-electrons.com>
 <2515980.d69ggAvHPo@wuerfel>
 <20150402161626.182e267d@free-electrons.com>
Message-ID: <20150402144823.GJ24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 04:16:26PM +0200, Thomas Petazzoni wrote:
> All customers have evaluation boards with a production stepping of the
> silicon, and for all of them the current kernel is *not* working.
> 
> The patch I'm proposing is what makes the kernel work for them.
> 
> Arnd, please don't get in the way of platform maintainers for such very
> platform-specific issues for which you don't have the background about
> what happened and why we're doing this change. It's the responsibility
> of the platform maintainers to decide how and when they want to keep or
> break the compatibility.

Wrong.  It's Arnd's responsibility to make sure that platform maintainers
don't do stupid things like change the DT in incompatible ways which
break lots of people's setups.

However, it is _your_ responsibility as the platform maintainer to place
sufficient information into the commit message that explains why the
change is necessary, and justifies the change.  Much of what you've said
in these follow-on emails should have been in the original message to
explain what the situation is, and why the change is appropriate.

I'm willing to bet that if the commit description had explained it
properly, Arnd would have applied it by now.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
