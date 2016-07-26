From: davem@davemloft.net (David Miller)
Date: Mon, 25 Jul 2016 21:52:01 -0700 (PDT)
Subject: [PATCH net-next v7 00/12] drivers: net: xgene: Fix module
 crash and 1G hot-plug
In-Reply-To: <1469491967-28627-1-git-send-email-isubramanian@apm.com>
References: <1469491967-28627-1-git-send-email-isubramanian@apm.com>
Message-ID: <20160725.215201.293002281412965878.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Mon, 25 Jul 2016 17:12:35 -0700

> This patchset addresses the following issues,
> 
> 1. Fixes the kernel crash when the driver loaded as an kernel module
> 	- by fixing hardware cleanups and rearrange kernel API calls
> 
> 2. Hot-plug issue on the SGMII 1G interface
> 	- by adding a driver for MDIO management
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> Tested-by: Fushen Chen <fchen@apm.com>
> Tested-by: Toan Le <toanle@apm.com>

Series applied, thank you.
