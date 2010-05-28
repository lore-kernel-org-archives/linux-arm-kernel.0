From: jamessteward@optusnet.com.au (James)
Date: Fri, 28 May 2010 16:43:41 +1000
Subject: DMA to static address
Message-ID: <1275029021.4690.83.camel@Ubuntu-Desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've been looking around in the kernel source and googling, and I'm
having trouble finding any information about doing a DMA transfer with
an I/O device that implements a single address for DMA.  I.e. the
external memory address should not be auto incremented during the
transfer.

Is that mode supported by the Linux generic DMA system, and where should
I look?

Specifically this is for the i.MX27 and friends.

Regards,
James.
