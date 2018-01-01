From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Jan 2018 13:25:20 +0000
Subject: [EXT] Re: [PATCH net-next 5/6] arm64: dts: marvell: mcbin:
 enable the fourth network interface
In-Reply-To: <616c2f3b0fe64184bc26d2de43442540@IL-EXCH01.marvell.com>
References: <20171228100519.GE2626@kwain>
 <462da70b-ba7d-6299-3e21-b619d3c4c7e6@gmail.com>
 <20171228182739.GH2626@kwain>
 <20171228184642.GV10595@n2100.armlinux.org.uk>
 <CAPv3WKdNCOB=1BqGXw7gXZNX+bBhOXVfheYPjC4CFZjfiOXyHQ@mail.gmail.com>
 <20171229113850.GX10595@n2100.armlinux.org.uk>
 <CAPv3WKcFT5YgvwEk9QNB5=O0j23ds1jCxaBYnMVhxDHeBZzbDA@mail.gmail.com>
 <20171230173157.GC10595@n2100.armlinux.org.uk>
 <CAPv3WKfn0=51CVtC8V5nWeiM+UV0BhqwFNewwRWUV3wy-9MtUg@mail.gmail.com>
 <616c2f3b0fe64184bc26d2de43442540@IL-EXCH01.marvell.com>
Message-ID: <20180101132520.GB28752@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 01, 2018 at 10:35:25AM +0000, Stefan Chulski wrote:
> 
> > -----Original Message-----
> > Hi Russell,
> > 
> > Indeed. RGMII MAC behaves same way, although it shouldn't be named as 'in-
> > band' to be on par with the specifications. Anyway - this one is rather a stub for
> > being able to work with ACPI, so once the MDIO bus works there, this will be
> > out of any concerns.
> 
> Hi Marcin,
> 
> This is correct.
> "in-band" supported only for SGMII mode.
> IRQ link interrupt depend on "in-band"' auto negation only if "in-band"' enabled.
> But IRQ link interrupt could be triggered with "in-band", "out-band" or with specific fixed speed/duplex/flow_contol.

Hi Stefan,

How does this work in RGMII mode - is this handled by the PP2 polling
the PHY to get the speed, duplex and flow control settings?

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
