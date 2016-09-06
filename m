From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 06 Sep 2016 19:17:09 +0200
Subject: [PATCH 8/8] ARM: pxa/lubbock: add pcmcia clock
In-Reply-To: <E1bhJNx-0008DR-2l@rmk-PC.armlinux.org.uk> (Russell King's
 message of "Tue, 06 Sep 2016 17:38:09 +0100")
References: <20160906163711.GB1041@n2100.armlinux.org.uk>
 <E1bhJNx-0008DR-2l@rmk-PC.armlinux.org.uk>
Message-ID: <87a8flhrsa.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@armlinux.org.uk> writes:

> Add the required PCMCIA clock for the SA1111 "1800" device.  This clock
> is used to compute timing information for the PCMCIA interface in the
> SoC device, rather than the SA1111.  Hence, the provision of this clock
> is a convenience for the driver and does not reflect the hardware, so
> this must not be copied into DT.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
But more importantly:
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
