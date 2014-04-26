From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Apr 2014 20:37:22 -0400
Subject: [PATCH 0/5] ARM: mvebu: misc Device Tree fixes and updates
In-Reply-To: <1397806908-7550-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397806908-7550-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140426003722.GO28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 09:41:43AM +0200, Thomas Petazzoni wrote:
> Jason, Gregory, Andrew, Sebastian,
> 
> Here are five patches making misc Device Tree fixes and updates for
> mvebu platforms:
> 
>  * The first patch is really a fix, that makes audio actually work on
>    Armada 370 DB. It should be merged as part of 3.15-rc.
> 
>  * The second patch enables the SATA interface on Armada 375 DB,
>    apparently something we forgot to do when submitting the initial
>    Armada 375 DB Device Tree. Not sure whether it's 3.15 or 3.16
>    material.
> 
>  * The last three patches are improvements to the Device Tree to use
>    the 'clocks' property for UART controllers instead of an hard-coded
>    'clock-frequency' property. This is clearly cleanup stuff, so 3.16
>    is in order.
> 
> Thanks!
> 
> Thomas
> 
> Thomas Petazzoni (5):
>   ARM: mvebu: specify I2C bus frequency on Armada 370 DB
>   ARM: mvebu: enable the SATA interface on Armada 375 DB
>   ARM: mvebu: use clocks property for serial ports
>   ARM: mvebu: remove clock-frequency of serial port Device Tree nodes
>   ARM: mvebu: don't use clocks property in UART node for Netgear RN2120

Patches 3, 4, and 5 applied to mvebu/dt (1 and 2 already in
mvebu/dt-fixes)

thx,

Jason.
