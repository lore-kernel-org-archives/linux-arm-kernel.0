From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 18 May 2010 10:25:06 +0200
Subject: [PATCH v3] PXA DMA-capable PATA driver
In-Reply-To: <4BF20FF6.4020506@garzik.org>
References: <1274137768-27707-1-git-send-email-marek.vasut@gmail.com>
	<4BF20FF6.4020506@garzik.org>
Message-ID: <201005181025.06985.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 18. kv?tna 2010 05:56:38 Jeff Garzik napsal(a):
> On 05/17/2010 07:09 PM, Marek Vasut wrote:
> > This patch adds a driver for a harddrive attached to PXA address and data
> > bus. Unlike pata_platform, this driver allows usage of PXA DMA
> > controller, making the transmission speed 3x higher.
> > 
> > Signed-off-by: Marek Vasut<marek.vasut@gmail.com>
> > ---
> > 
> >   arch/arm/mach-pxa/include/mach/pata_pxa.h |   33 +++
> >   drivers/ata/Kconfig                       |   11 +
> >   drivers/ata/Makefile                      |    1 +
> >   drivers/ata/pata_pxa.c                    |  404
> >   +++++++++++++++++++++++++++++ 4 files changed, 449 insertions(+), 0
> >   deletions(-)
> >   create mode 100644 arch/arm/mach-pxa/include/mach/pata_pxa.h
> >   create mode 100644 drivers/ata/pata_pxa.c
> 
> Acked-by: Jeff Garzik <jgarzik@redhat.com>
> 
> There are a few minor issues remaining, but we can take care of them
> post-merge.  I presume you'll send this via arm tree.

If you're fine with it, I guess that'd be the best way.

Thanks!
