From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 27 Aug 2015 17:43:03 -0700
Subject: [PATCH v2 3/5] ARM: NSP: Add basic support for Broadcom Northstar
 Plus SoC
In-Reply-To: <1440628530-6137-4-git-send-email-jonmason@broadcom.com>
References: <1440628530-6137-1-git-send-email-jonmason@broadcom.com>
 <1440628530-6137-4-git-send-email-jonmason@broadcom.com>
Message-ID: <55DFAE97.3030003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/08/15 15:35, Jon Mason wrote:
> Broadcom Northstar Plus family of SoCs are used for switching
> control and management applications as well as residential
> router/gateway applications. The SoC features dual core Cortex
> A9 ARM CPUs, integrating several peripheral interfaces including
> multiple Gigabit Ethernet PHYs, DDR3 memory, PCIE Gen-2, USB 2.0
> and USB 3.0, serial and NAND flash, SATA and several other IO
> controllers.
> 
> Signed-off-by: Kapil Hali <kapilh@broadcom.com>
> Signed-off-by: Jon Mason <jonmason@broadcom.com>

Applied to soc/next at github.com/stblinux, thanks!

This is a little late for 4.3, so this will be queued for 4.4, thanks!
-- 
Florian
