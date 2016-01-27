From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Jan 2016 09:36:10 +0000
Subject: [PATCH v4 0/2] pci: Add host controller driver for Cavium
 ThunderX PCIe
In-Reply-To: <1453844781-24380-1-git-send-email-ddaney.cavm@gmail.com>
References: <1453844781-24380-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160127093609.GA2390@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 01:46:19PM -0800, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Some Cavium ThunderX processors require quirky access methods for the
> config space of the PCIe bridge.
> 
> There are two patches:
> 
> 1) Refactor code in pci-host-generic so that it can more easily be
>    used by other drivers.  This splits the driver for CAM and ECAM
>    access methods to a separate file from the common host driver code.
> 
> 2) Add the ThunderX PCIe driver, which leverages the code in
>    pci-host-generic
> 
> Changes from v3: Add some Acked-by, rebased to v4.5.0-rc1
> 
> Changes from v2: Improve device tree binding example as noted by Rob
> Herring.  Rename pcie-thunder-pem.* to pci-thunder-pem.* for better
> consistency.  Update MAINTAINERS to reflect the changes.
> 
> Changes from v1: Split CAM and ECAM code from common driver code as
> suggested by Arnd Bergmann.  Fix spelling errors in
> pcie-thunder-pem.txt

Bjorn -- I guess you'll pick these up directly?

Will
