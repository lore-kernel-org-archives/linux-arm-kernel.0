From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 08:40:31 +0000
Subject: [PATCHv3 1/4] ARM: tegra: Add Tegra AHB driver
In-Reply-To: <20120504.094030.1816474762821188264.hdoyu@nvidia.com>
References: <1336061147-10245-1-git-send-email-hdoyu@nvidia.com>
 <4FA2C785.2080703@wwwdotorg.org>
 <20120504.094030.1816474762821188264.hdoyu@nvidia.com>
Message-ID: <201205040840.32337.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 May 2012, Hiroshi Doyu wrote:
> > This patch should add
> > Documentation/devicetree/bindings/arm/tegra/tegra20-ahb.txt to describe
> > the DT binding.
> 
> From 'dts' POV, there's no difference between tegra20 and
> tegra30. They just have a register range. Is
> "../bindings/arm/tegra/tegra-ahb.txt" ok, instead of having both
> tegra{20,30}-ahb.txt?

I think either one is ok. Just calling it tegra20-ahb.txt would be
fine too because tegra30 is compatible to that.

	Arnd
