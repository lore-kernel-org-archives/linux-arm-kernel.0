From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 30 Mar 2013 14:13:26 +0000
Subject: [PATCH 1/2] ARM: tegra: move <mach/powergate.h> to
 <linux/tegra-powergate.h>
In-Reply-To: <1364602790-10759-1-git-send-email-swarren@wwwdotorg.org>
References: <1364602790-10759-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201303301413.26549.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 30 March 2013, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This is required so that code such as Tegra's PCIe and clock drivers
> can still access this header file once Tegra is converted to
> multiplatform, and <mach/> no longer exists.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

It sounds like this should be integrated in the reset controller API
that Philipp Zabel just posted. I'm not blaming you for now knowing
about it, since I only saw it myself a few days ago, and my interpretation
could be wrong. Are you able to move to that API before 3.10?

If not, we can probably take your patch for now, if you remove it
again for 3.11.

	Arnd
