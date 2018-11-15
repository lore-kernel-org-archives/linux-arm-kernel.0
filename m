From: maxime.chevallier@bootlin.com (Maxime Chevallier)
Date: Thu, 15 Nov 2018 11:02:29 +0100
Subject: [RFC PATCH 2/6] phy: armada38x: add common phy support
In-Reply-To: <E1gMBMi-00089Q-7S@rmk-PC.armlinux.org.uk>
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
 <E1gMBMi-00089Q-7S@rmk-PC.armlinux.org.uk>
Message-ID: <20181115110229.45bcf903@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, 12 Nov 2018 12:30:52 +0000
Russell King <rmk+kernel@armlinux.org.uk> wrote:

>Add support for the Armada 38x common phy to allow us to change the
>speed of the Ethernet serdes lane.  This driver only supports
>manipulation of the speed, it does not support configuration of the
>common phy.

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

>Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
Maxime Chevallier, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
