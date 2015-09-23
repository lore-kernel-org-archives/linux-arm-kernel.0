From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 22 Sep 2015 17:58:07 -0700
Subject: [PATCH v3 0/9] Broadcom Cygnus device tree changes
In-Reply-To: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
References: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
Message-ID: <5601F91F.1020307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/09/15 15:12, Ray Jui wrote:
> This patch series cleans up the Broadcom Cygnus device tree files and makes it
> more consistent with the rest of Broadcom iProc device tree files. This patch
> series also enables various peripherals on Cygnus boards. They include:
> 
> bcm11360_entphn:
> NAND
> 
> bcm958300k:
> touchscreen
> 
> bcm958305k:
> I2C, PCIe, NAND, touchscreen
> 
> Code is based on v4.3-rc1 and is available on GITHUB:
> https://github.com/Broadcom/cygnus-linux/tree/cygnus-dt-v3
> 
> Changes from V2:
>  - Drop PCIe device node change that removes the I/O resource
>  - Set up appropriate address range for the 'core' bus
>  - Rename the 'soc' bus node to 'axi'
>  - Remove incorrect 3rd compatible string 'brcm,brcmnand' in the NAND node
> 
> Chages from V1:
>  - Break the major clean up change into separate patches

Series applied, thanks!
-- 
Florian
