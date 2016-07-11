From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Mon, 11 Jul 2016 10:07:31 +0000
Subject: [PATCH v4] Axi-usb: Add support for 64-bit addressing.
References: <1464626798-1334-1-git-send-email-navam@xilinx.com>
 <20160602225815.GA5508@rob-hp-laptop>
Message-ID: <C89496FEAE474D468F30D558A9468D9F26CF8BC0@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping!!

> -----Original Message-----
> From: Nava kishore Manne
> Sent: Monday, June 27, 2016 6:18 PM
> To: 'Rob Herring' <robh@kernel.org>
> Cc: pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek
> <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
> balbi at ti.com; gregkh at linuxfoundation.org; Hyun Kwon
> <hyunk@xilinx.com>; Radhey Shyam Pandey <radheys@xilinx.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: RE: [PATCH v4] Axi-usb: Add support for 64-bit addressing.
>
> Ping!!
>
> > -----Original Message-----
> > From: Rob Herring [mailto:robh at kernel.org]
> > Sent: Friday, June 03, 2016 4:28 AM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: pawel.moll at arm.com; mark.rutland at arm.com;
> > ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek
> > <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
> > balbi at ti.com; gregkh at linuxfoundation.org; Hyun Kwon
> > <hyunk@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; Radhey
> > Shyam Pandey <radheys@xilinx.com>; devicetree at vger.kernel.org; linux-
> > arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> > Subject: Re: [PATCH v4] Axi-usb: Add support for 64-bit addressing.
> >
> > On Mon, May 30, 2016 at 10:16:38PM +0530, Nava kishore Manne wrote:
> > > This patch updates the driver to support 64-bit DMA addressing.
> > >
> > > Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> > > ---
> > > Changes for v4:
> > >           -Used boolen property insted of addrwith property in the DT
> > >            as suggested by Arnd Bergmann.
> > >           -Adopt the DT relevant changes into the driver.
> > >
> > > Changes for v3:
> > >                 -Added new compatable string for 5.00 IP version as suggested by
> > >                  Arnd Bergmann.
> > >                 -Used write_fn() insted of lo_hi_writeq() as suggested by
> > >                  Arnd Bergmann.
> > >
> > > Changes for v2:
> > >                 -Added dma-ranges property in device tree as
> > > suggested by Arnd
> > Bergmann.
> > >                 -Modified the driver code based on the xlnx,addrwidth.
> > >
> > >  .../devicetree/bindings/usb/udc-xilinx.txt         |  5 ++-
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> >
> > >  drivers/usb/gadget/udc/udc-xilinx.c                | 52
> > +++++++++++++++++++++-
> > >  2 files changed, 54 insertions(+), 3 deletions(-)


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
