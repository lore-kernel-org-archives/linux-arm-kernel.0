From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 May 2012 13:45:59 -0600
Subject: [PATCHv5 1/3] ARM: tegra: Add Tegra AHB driver
In-Reply-To: <20120507.143647.508182574757518311.hdoyu@nvidia.com>
References: <201205070859.29174.arnd@arndb.de><20120507.122333.2024326166703361049.hdoyu@nvidia.com><201205071024.48958.arnd@arndb.de>
 <20120507.143647.508182574757518311.hdoyu@nvidia.com>
Message-ID: <4FA977F7.9080806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2012 05:36 AM, Hiroshi Doyu wrote:
...
> Tegra AHB Bus conforms to the AMBA Specification (Rev 2.0) Advanced
> High-performance Bus (AHB) architecture.
> 
> The AHB Arbiter controls AHB bus master arbitration. This effectively
> forms a second level of arbitration for access to the memory
> controller through the AHB Slave Memory device. The AHB pre-fetch
> logic can be configured to enhance performance for devices doing
> sequential access. Each AHB master is assigned to either the high or
> low priority bin. Both Tegra20/30 have this AHB bus.

I've applied this (minus the Change-Id line) and the other two patches
to Tegra's for-next branch. I'll let it sit there for a day or two
before sending a pull request into arm-soc for 3.5; hopefully it's not
too late for that.
