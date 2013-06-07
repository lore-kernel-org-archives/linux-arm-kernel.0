From: luke.leighton@gmail.com (luke.leighton)
Date: Fri, 7 Jun 2013 22:29:34 +0100
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <20130607205940.4816fed5@skate>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <1370475609.20454.44.camel@localhost>
 <CAPweEDwS3tR=wh-bZJb3vqR8fVQra=3XxDitowGRdH9c7WRfmQ@mail.gmail.com>
 <1733666.lHUBcfUXq9@flatron> <20130606112723.71ddd70c@skate>
 <CAPweEDzW60poOYahm31aW3_A=NvZmyBPPPgM9PzdvuPJnju69A@mail.gmail.com>
 <20130607205940.4816fed5@skate>
Message-ID: <CAPweEDxtC+OamcpVEQ3BULbN88hSJzKoi0fkNLBAdZD04LQCNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 7, 2013 at 7:59 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> Maxime will reply to this in more details, but I believe the status is:
>
>  * Interrupt controller is working.
>  * Clock drivers are working.
>  * Pinctrl is working.
>  * GPIO is working.
>  * Timer is working.
>  * UART is working
>  * Watchdog is on its way (patches posted)
>  * Ethernet is on its way (patches posted)
>  * I2C is on its way (patches posted)

 ok so i've got this now in
http://hands.com/~lkcl/allwinner_linux_proposal.txt - that leaves...
well there's quite a bit: usb, sd/mmc (both variants: they changed the
data structures around sun5i), nand (probably both - the allwinner one
and the mtd one being done, reminds me: we need full documentation on
the NAND chip), scsi, g2d - cedarx and more.

 what else should be raised, and to what benefit?
