From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Oct 2011 22:18:34 +0100
Subject: [GIT PULL] i.MX6Q support
In-Reply-To: <20111020171158.GJ32007@S2100-06.ap.freescale.net>
References: <20111020171158.GJ32007@S2100-06.ap.freescale.net>
Message-ID: <20111020211834.GF21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2011 at 01:11:59AM +0800, Shawn Guo wrote:
> Please pull imx6q series.  It's based on v3.1-rc10 with the following
> branches merged plus a number of cache-l2x0 patches currently sitting
> on rmk/for-next.

Don't do that.  If there's something you need, _ask_ me.  The L2x0
patches got shuffled out into their own branch when the SMP and debug
patches got split out of the 'misc' branch.
