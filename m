From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 23 May 2016 11:36:14 -0400
Subject: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
In-Reply-To: <1462893601-8937-1-git-send-email-tn@semihalf.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
Message-ID: <5743236E.6090801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/10/2016 11:19 AM, Tomasz Nowicki wrote:
> From the functionality point of view this series may be split into the
> following logic parts:
> 1. New ECAM API and update for users of the pci-host-common API
> 2. Necessary fixes as the preparation for using driver on ARM64.
> 3. Use new MCFG interface and implement generic ACPI based PCI host controller driver.
> 4. Enable above driver on ARM64
> 
> Patches has been built on top of 4.6-rc7 and can be found here:
> git at github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v7)
> 
> This has been tested on Cavium ThunderX server. Any help in reviewing and
> testing is very appreciated.
> 

Tested on Qualcomm QDF2XXX server using Mellanox CX3 and Intel e1000e adapters.

Tested-by: Sinan Kaya <okaya@codeaurora.org>



-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
