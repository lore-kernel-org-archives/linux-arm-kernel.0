From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Sep 2016 10:10:27 +0100
Subject: [PATCH 8/8] ARM: pxa/lubbock: add pcmcia clock
In-Reply-To: <87a8flhrsa.fsf@belgarion.home>
References: <20160906163711.GB1041@n2100.armlinux.org.uk>
 <E1bhJNx-0008DR-2l@rmk-PC.armlinux.org.uk>
 <87a8flhrsa.fsf@belgarion.home>
Message-ID: <20160907091027.GI1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 07:17:09PM +0200, Robert Jarzmik wrote:
> Russell King <rmk+kernel@armlinux.org.uk> writes:
> 
> > Add the required PCMCIA clock for the SA1111 "1800" device.  This clock
> > is used to compute timing information for the PCMCIA interface in the
> > SoC device, rather than the SA1111.  Hence, the provision of this clock
> > is a convenience for the driver and does not reflect the hardware, so
> > this must not be copied into DT.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> But more importantly:
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Thanks Robert.  I guess no one else is be interested in these patches,
so I'm going to drop them into -next today, and send them on Friday or
over this weekend.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
