From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Jun 2015 22:44:32 +0100
Subject: [PATCHv2 1/7] arm: perf: factor arm_pmu core out to drivers
In-Reply-To: <20150616161728.GI30522@arm.com>
References: <1434041060-16378-1-git-send-email-mark.rutland@arm.com>
 <1434041060-16378-2-git-send-email-mark.rutland@arm.com>
 <20150616161728.GI30522@arm.com>
Message-ID: <20150616214432.GV7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 05:17:28PM +0100, Will Deacon wrote:
> I wonder whether that's such a good name for the subsystem. We already
> have a bunch of perf_* headers directly under include/linux/ for the perf
> core interfaces, so maybe drivers/pmu/ would be better?

I think drivers/perf/ is better than drivers/pmu/.  PMU can mean many
things - performance monitor unit, power management unit, ...

There comes a point where the use of TLAs becomes excessive, confusing
and annoying, and I think this is it.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
