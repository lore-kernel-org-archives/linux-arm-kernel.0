From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 6 Jun 2017 11:02:50 +0100
Subject: [PATCH] arm64: dts: marvell: cp110: add required clocks for mdio
 interface
In-Reply-To: <1496743035-4618-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1496743035-4618-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <f98113fd-800e-c3c3-3e39-574e228faa7a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/17 10:57, Thomas Petazzoni wrote:
> From: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Add the three required clocks for the MDIO interface to be functional
> on Armada 8k platforms.  Without this, the CPU hangs, causing RCU
> stalls or the system to become unresponsive.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> [Thomas:
>  - remove mg_core_clock, since it's a parent of mg_clock
>  - also add clock references to the slave CP mdio instance]
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Tested-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
