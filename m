From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Apr 2017 16:05:03 +0100
Subject: [PATCH v3 0/9] Fix issues and factorize arm/arm64 capacity
 information code
In-Reply-To: <20170327131825.32134-1-juri.lelli@arm.com>
References: <20170327131825.32134-1-juri.lelli@arm.com>
Message-ID: <20170410150503.GS17774@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 02:18:16PM +0100, Juri Lelli wrote:
> arm and arm64 topology.c share a lot of code related to parsing of capacity
> information. This is v3 of a solution [1] (based on Will's, Catalin's and
> Mark's off-line suggestions) to move such common code in a single place:
> drivers/base/arch_topology.c (by creating such file and conditionally compiling
> it for arm and arm64 only).

I think overall this is okay, with the exception of one patch which seems
to be wrongly worded.  Once that's resolved, then:

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

for the series.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
