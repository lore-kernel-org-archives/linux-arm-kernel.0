From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Jan 2015 16:21:50 +0000
Subject: [PATCH v5 0/7] Enable L2 cache support on Exynos4210/4x12 SoCs
In-Reply-To: <20150114154603.GK3843@piout.net>
References: <1411556741-5810-1-git-send-email-m.szyprowski@samsung.com>
 <20150114154603.GK3843@piout.net>
Message-ID: <20150114162150.GQ11502@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 04:46:03PM +0100, Alexandre Belloni wrote:
> Hi,
> 
> This patch set hasn't moved since while. We actually need patch 4 to
> properly configure prefetch on sama5d4. What would be needed to come to
> an agreement ?

What do you mean "hasn't moved since a while" - there has been movement.
It was discovered that it breaks OMAP4 platforms.

Since then, work has been done to resolve that breakage, and I've merged
the recent patch set into my tree for further regression testing, and
I'm going to push it out to linux-next later this week.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
