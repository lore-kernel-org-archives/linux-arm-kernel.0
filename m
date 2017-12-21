From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 21 Dec 2017 20:21:56 +0100
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <1513588684-15647-1-git-send-email-mw@semihalf.com>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
Message-ID: <20171221192156.GA8067@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,

On Mon, Dec 18, 2017 at 10:17:56AM +0100, Marcin Wojtas wrote:
> 
> Marcin Wojtas (8):
>   device property: Introduce fwnode_get_mac_address()
>   device property: Introduce fwnode_get_phy_mode()
>   mdio_bus: Introduce fwnode MDIO helpers
>   net: mvmdio: add ACPI support
>   net: mvpp2: simplify maintaining enabled ports' list
>   net: mvpp2: use device_*/fwnode_* APIs instead of of_*
>   net: mvpp2: handle PHY with its fwnode
>   net: mvpp2: enable ACPI support in the driver


I tested your series on a mcbin, using the dt way. It still worked. If
it is relevant, you can add on the mvpp2 related patches:

Tested-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
