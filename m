From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 9 Jul 2014 10:24:45 -0400
Subject: [PATCH 0/3] ARM: keystone: enable mdio support
In-Reply-To: <1404911660-10047-1-git-send-email-grygorii.strashko@ti.com>
References: <1404911660-10047-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <53BD50AD.80704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 July 2014 09:14 AM, Strashko, Grygorii wrote:
> Add DT definitions for Keystone 2 MDIO module and Ethernet PHYs for Keystone
> EVMK2HX evm. And enable MDIO support for Keystone 2 SoCs.
> 
> Grygorii Strashko (3):
>   ARM: dts: keystone: add mdio devices entries
>   ARM: dts: keystone-evm: add 1g ethernet phys nodes
>   ARM: keystone_defconfig: enable mdio and marvell eth phys
> 
Series looks good. I will merge it when the driver changes gets
merged. Please ping me just in case I forget about it.

Thanks !!

Regards,
Santosh
