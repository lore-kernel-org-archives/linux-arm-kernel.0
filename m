From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 28 Oct 2009 01:14:59 +0100
Subject: [PATCH] USB: Add EHCI support for MX27 and MX31 based boards
Message-ID: <20091028001459.GB14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the generic ULPI OTG bits have been picked now, the last thing for
USB on MX2/MX3 SoCs that needs to go thru the USB people's channel is
the EHCI driver itself. There is still the MXC spcific ULPI
implementation which I will submit seperately.

I rebased this patch to apply to the current mainline git. Is there
anything I can do to speed up things a little? IIRC, there was still no
Ack from David Brownell, which was the reason why it wasn't considered
for merging yet.

Thanks,
Daniel
