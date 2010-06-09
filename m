From: jason.mcmullan@netronome.com (Jason McMullan)
Date: Wed, 9 Jun 2010 14:06:53 -0400
Subject: [PATCH] [kirkwood-otg] Leverage the Freescale OTG driver for
	Kirkwood OTG
In-Reply-To: <alpine.LFD.2.00.1006091307321.30664@xanadu.home>
References: <1276094138-13497-1-git-send-email-jason.mcmullan@netronome.com>
	<1276094138-13497-2-git-send-email-jason.mcmullan@netronome.com>
	<alpine.LFD.2.00.1006091307321.30664@xanadu.home>
Message-ID: <AANLkTikVeVBdSfeS_p0k4dRwFopELw2OIXUrS1NjEdt6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 9, 2010 at 1:17 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Wed, 9 Jun 2010, Jason S. McMullan wrote:
>> NOTE: Your bootloader must ensure that the Kirkwood
>> ? ? ? USB 2.0 Bridge Window registers are set correctly,
>> ? ? ? or the driver will stall on the first DMA.
>
> Could you add the code to sets that up in the kernel instead?

Will do.

>> ?config USB_GADGET_FSL_USB2
>
> Maybe the help text should be extended to mention Kirkwood?

Again, good idea, will do.

-- 
Jason S. McMullan
Netronome Systems, Inc.
