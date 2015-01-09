From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 9 Jan 2015 16:20:17 +0100
Subject: [PATCH v4 00/12]  Add Armada 38x GP and AP boards support
In-Reply-To: <1420738694-6163-1-git-send-email-gregory.clement@free-electrons.com>
References: <1420738694-6163-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150109152017.GB18832@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Gregory CLEMENT (5):
>   ARM: mvebu: a38x: Add more pinctrl functions
>   ARM: mvebu: a38x: Add missing labels
>   ARM: mvebu: Document the Device Tree binding for the Armada 388 SoC
>   ARM: mvebu: Add Device Tree description of the Armada 388 SoC
>   ARM: mvebu: Add Armada 388 General Purpose Development Board support

All added to mvebu/dt

> 
> Maxime Ripard (7):
>   ARM: mvebu: Rename DEBUG_LL to indicate UART index
>   ARM: mvebu: Add UART1 as DEBUG_LL possible target

Added to mvebu/soc

>   ARM: mvebu: a38x: Fix node names

All added to mvebu/dt

>   pinctrl: mvebu: a38x: Add UART1 muxing options

Linus took this one already

>   ARM: mvebu: A38x: Remove redundant pinctrl informations
>   ARM: mvebu: Add a number of pinctrl functions
>   ARM: mvebu: Add Armada 385 Access Point Development Board support

All added to mvebu/dt

Thanks
	Andrew
