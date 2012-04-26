From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Apr 2012 13:51:28 -0600
Subject: [PATCHv3 1/4] ARM: tegra: Add AHB driver
In-Reply-To: <1335352072-4001-1-git-send-email-hdoyu@nvidia.com>
References: <1335352072-4001-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <4F99A740.3080407@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2012 05:07 AM, Hiroshi DOYU wrote:
> The AHB Bus conforms to the AMBA Specification (Rev 2.0) Advanced
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

I think this code looks reasonable. I'd like to see an ack from Russell,
Arnd, and Olof on the final location of the files though.

I note that MAINTAINERS doesn't have an entry for drivers/platform/
(except x86/ sub-dir) or drivers/platform/arm/.
