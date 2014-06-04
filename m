From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 04 Jun 2014 13:30:55 +0200
Subject: [PATCH v2 4/7] ARM: shmobile: r8a7791: Add SYS-DMAC channel
 definitions for bindings
In-Reply-To: <CAMuHMdWkPy8eydh4BntXdtf5ZJKP4yG26QovLUjvGUYYv3dStw@mail.gmail.com>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
 <538C818B.5060703@codethink.co.uk>
 <CAMuHMdWkPy8eydh4BntXdtf5ZJKP4yG26QovLUjvGUYYv3dStw@mail.gmail.com>
Message-ID: <3770565.HiyLmu1184@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 June 2014 09:53:17 Geert Uytterhoeven wrote:
> On Mon, Jun 2, 2014 at 3:52 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> >> +// FIXME
> >> +#define CHCR_RX_8BIT SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_8BIT)
> >> +#define CHCR_TX_8BIT SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_8BIT)
> >> +#define CHCR_RX_16BIT        SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_16BIT)
> >> +#define CHCR_TX_16BIT        SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_16BIT)
> >> +#define CHCR_RX_32BIT        SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_32BIT)
> >> +#define CHCR_TX_32BIT        SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_32BIT)
> >> +#define CHCR_RX_256BIT       SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_256BIT)
> >> +#define CHCR_TX_256BIT       SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_256BIT)
> > 
> > I am pretty sure for round-2 we can remove these in favour of a
> > table in the driver. The only device that has a non-standard setting
> > is the SDHI and that will support 32bit and 256bit transfers.
> 
> Thanks, I'm eagerly awaiting your next version...

Speaking of that, Ben, do you have a git tree with your latest patches ?

-- 
Regards,

Laurent Pinchart
