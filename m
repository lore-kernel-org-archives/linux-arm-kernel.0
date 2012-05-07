From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 May 2012 08:04:28 +0000
Subject: [PATCHv5 1/3] ARM: tegra: Add Tegra AHB driver
In-Reply-To: <1336373032-16881-1-git-send-email-hdoyu@nvidia.com>
References: <1336373032-16881-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <201205070804.29154.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 May 2012, Hiroshi DOYU wrote:
> Tegra AHB Bus conforms to the AMBA Specification (Rev 2.0) Advanced
> High-performance Bus (AHB) architecture.
> 
> The AHB Arbiter controls AHB bus master arbitration. This effectively
> forms a second level of arbitration for access to the memory
> controller through the AHB Slave Memory device. The AHB pre-fetch
> logic can be configured to enhance performance for devices doing
> sequential access. Each AHB master is assigned to either the high or
> low priority bin. Both Tegra20/30 have this AHB bus.
> 
> Some of configuration params could be passed from DT too if needed.
> 
> Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

for the driver, but please fix the issue pointed out by Russell.

	Arnd
