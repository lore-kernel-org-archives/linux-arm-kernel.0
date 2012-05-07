From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 May 2012 10:24:48 +0000
Subject: [PATCHv5 1/3] ARM: tegra: Add Tegra AHB driver
In-Reply-To: <20120507.122333.2024326166703361049.hdoyu@nvidia.com>
References: <20120507074228.GK26481@n2100.arm.linux.org.uk>
 <201205070859.29174.arnd@arndb.de>
 <20120507.122333.2024326166703361049.hdoyu@nvidia.com>
Message-ID: <201205071024.48958.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 May 2012, Hiroshi Doyu wrote:
> Tegra doesn't enable ARM_AMBA and Tegra doesn't use the following
> "drivers/amba/bus.c" right now. I needed to make this directory
> available to ones without ARM_AMBA enabled.

Ah, right. I looked at arch/arm/Kconfig earlier to see if
tegra enabled ARM_AMBA but was accidentally looking
at ARCH_INtegraTOR when grepping for TEGRA ;-)

Your proposed solution sounds good then.

	Arnd
