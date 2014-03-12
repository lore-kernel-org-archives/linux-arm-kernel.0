From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Mar 2014 11:03:16 +0000
Subject: CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS and bcm2835_defconfig
In-Reply-To: <531FE40C.1060709@wwwdotorg.org>
References: <alpine.DEB.2.10.1403101717050.31525@vincent-weaver-1.um.maine.edu>
 <531FE40C.1060709@wwwdotorg.org>
Message-ID: <20140312110315.GG21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 10:35:24PM -0600, Stephen Warren wrote:
> Hmm. I thought that ARMv6 didn't have efficient unaligned accesses, but
> I suppose it must; ARM selects HAVE_EFFICIENT_UNALIGNED_ACCESS for
> v6/v6k/v7. BUILTIN_BSWAP seems innocuous. Can you verify which of those
> two options actually causes problems for you?

What do you think is different between v6 and v7 for unaligned accesses?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
