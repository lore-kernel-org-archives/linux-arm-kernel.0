From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 17 Jul 2012 18:52:18 +0200
Subject: [PATCH] [RFC] arm: add documentation describing Marvell families
 of SoC
In-Reply-To: <20120717174037.0b7e9a79@skate>
References: <1342535201-12907-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201207171509.30509.arnd@arndb.de> <20120717174037.0b7e9a79@skate>
Message-ID: <20120717165218.GK4015@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> It would however be really nice to have comments on the document from
> the PXA/MMP people, because for now it has just been written based on
> some quick reading of Kconfig files and random stuff on the web.
> 
> Also, any clues on how to make it clearly appear that the
> Dove/Discovery/Kirkwood/Armada-370-XP families are completely separate
> from the PXA/MMP/MMP2 families? I was thinking, for each family, to
> list the device drivers that are actually being used for the different
> IPs of the SoCs, but I don't know if it is actually useful or not.

I think it would be useful. Adding DT and clk framework support i
always wounder which platforms i've just broken. It would also be good
to not limit it just to drivers shared within ARM. It seems like the
I2C driver is also shared with a few PPC devices. The Ethernet driver
is also used by PPC. Similar for the SATA i think, plus i think it can
also be used on PCI cards!

     Andrew
