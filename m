From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Jun 2014 10:44:23 +0100
Subject: [PATCH] ARM: dts: berlin2q.dtsi: set L2CC tag and data latency
 as 2 cycles
In-Reply-To: <1402565920-5636-1-git-send-email-jszhang@marvell.com>
References: <1402565920-5636-1-git-send-email-jszhang@marvell.com>
Message-ID: <20140612094423.GC23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 05:38:40PM +0800, Jisheng Zhang wrote:
> For all BG2Q SoCs, 2 cycles is the best/correct value

It would be a good idea to set all these parameters if you need to set
them at all - in other words, setting arm,dirty-latency as well, as
that's all part of the timing specification.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
