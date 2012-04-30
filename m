From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Apr 2012 14:47:36 +0000
Subject: [PATCHv3 1/4] ARM: tegra: Add AHB driver
In-Reply-To: <20120427084015.cb7c8e00c7d9a4cd01faa5ae@nvidia.com>
References: <1335352072-4001-1-git-send-email-hdoyu@nvidia.com>
 <20120426215903.GH24211@n2100.arm.linux.org.uk>
 <20120427084015.cb7c8e00c7d9a4cd01faa5ae@nvidia.com>
Message-ID: <201204301447.36246.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2012, Hiroshi Doyu wrote:
> What about having this driver under "drivers/amba"?
> 
> If other similiar drivers are coming up, it's easy to find rather than
> having this arch/arm/mach-*. There may be some possibility of
> generalization later, then. Also it meets the requirement of no
> "struct xxxx_driver" under arch/arm. Arnd?

I'm fine with either drivers/amba (arguing that it's for a specific
amba bus even if it's highly platform specific) or arch/arm/mach-tegra
(arguing that it's platform code and not actually a device driver even
if it appears like one). If Russell doesn't mind having it in
drivers/amba, I'd say we should go for that.

	Arnd
