From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 03 May 2012 11:59:33 -0600
Subject: [PATCHv3 1/4] ARM: tegra: Add Tegra AHB driver
In-Reply-To: <1336061147-10245-1-git-send-email-hdoyu@nvidia.com>
References: <1336061147-10245-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <4FA2C785.2080703@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2012 10:05 AM, Hiroshi DOYU wrote:
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
> Some of configuration param could be passed from DT too.

This patch should add
Documentation/devicetree/bindings/arm/tegra/tegra20-ahb.txt to describe
the DT binding.
