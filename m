From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Oct 2012 18:38:51 +0200
Subject: [PATCH v2 1/4] net: mvneta: driver for Marvell Armada 370/XP
 network unit
In-Reply-To: <5076E9F1.60200@gmail.com>
References: <1349969282-12676-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1349969282-12676-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <5076E9F1.60200@gmail.com>
Message-ID: <20121011183851.277e79da@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Thu, 11 Oct 2012 10:46:57 -0500, Rob Herring wrote:

> > +Required properties:
> > +- compatible: should be "marvell,neta".
> 
> This should be more specific such as "marvell,armada-xp-neta".
> 
> Or use 370 instead of xp. It should be which ever chip came first.
> 
> > +- reg: address and length of the register set for the device.
> > +- interrupts: interrupt for the device
> > +- phy-mode: String, operation mode of the PHY interface. Supported
> > +  values are "sgmii" and "rmii".
> > +- phy-addr: Integer, address of the PHY.
> > +- device_type: should be "network".
> 
> Drop this. device_type is not used for FDT.
> 
> > +- clock-frequency: frequency of the peripheral clock of the SoC.
> > +
> > +Example:
> > +
> > +eth at d0070000 {
> 
> Should be ethernet at ...

Thanks for your comments. Will fix in v3.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
