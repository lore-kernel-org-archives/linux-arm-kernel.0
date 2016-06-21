From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 21 Jun 2016 11:53:06 -0400 (EDT)
Subject: [PATCH v4] usb: ohci-at91: Forcibly suspend ports while USB
 suspend
In-Reply-To: <57695F33.5080306@atmel.com>
Message-ID: <Pine.LNX.4.44L0.1606211151380.2250-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Jun 2016, Nicolas Ferre wrote:

> Le 21/06/2016 03:32, Wenyou Yang a ?crit :
> > In order to save power consumption, as a workaround, forcibly suspend
> > the USB PORTA/B/C via setting the SUSPEND_A/B/C bits of OHCI Interrupt
> > Configuration Register in the SFR while OHCI USB suspend.
> > 
> > This suspend operation must be done before the USB clock is disabled,
> > resume after the USB clock is enabled.
> > 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Alan, can you take it as it doesn't have dependency on the at91 material
> anymore.

Sorry, I will not accept this patch until Wenyou Yang answers the 
questions I raised in

	http://marc.info/?l=linux-usb&m=146307669102601&w=2

and

	http://marc.info/?l=linux-usb&m=146541324027407&w=2

Alan Stern
