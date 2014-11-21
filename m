From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 21 Nov 2014 18:20:31 +0100
Subject: [PATCHv3 09/16] ARM: mvebu: implement suspend/resume support for
 Armada XP
In-Reply-To: <20141121175957.6ef4f26d@free-electrons.com>
References: <1416585613-2113-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1416585613-2113-10-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141121164142.GB20238@lunn.ch>
 <20141121175957.6ef4f26d@free-electrons.com>
Message-ID: <20141121172031.GC20238@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Hi Thomas
> > 
> > Is this a well defined mechanism supported by mainline uboot, barebox
> > etc. Or is it some Marvell extension to their uboot?
> 
> As far as I know, it is a Marvell extension to their "binary header",
> so it's done even before U-Boot starts.

Ah, O.K. So i miss understood what you meant by bootloader. It is the
first stage boot loader as part of the BootROM that does this.

If i've got this wrong, probably others will as well. So could you
make the comments talk about BootROM bootloader?

Thanks
	Andrew
