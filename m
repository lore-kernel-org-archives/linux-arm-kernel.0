From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 11 Jul 2016 18:05:44 +0200
Subject: [PATCH] ARM: dts: armada-388-clearfog: remove duplicate mdio entry
In-Reply-To: <20160710203220.GA26397@lunn.ch> (Andrew Lunn's message of "Sun,
 10 Jul 2016 22:32:20 +0200")
References: <E1bMGdu-00005c-Dy@rmk-PC.armlinux.org.uk>
 <20160710203220.GA26397@lunn.ch>
Message-ID: <87eg70tb1j.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
 
 On dim., juil. 10 2016, Andrew Lunn <andrew@lunn.ch> wrote:

> On Sun, Jul 10, 2016 at 04:27:38PM +0100, Russell King wrote:
>> The clearfog DTS should not be defining the on-board phy, this device
>> is located on the microsom.  Remove the duplicated definition.
>> 
>> Reported-by: Jon Nettleton <jon@solid-run.com>
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Applied on mvebu/dt

Thanks,

Gregory

>
>     Andrew

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
