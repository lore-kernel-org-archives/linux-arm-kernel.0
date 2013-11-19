From: balbi@ti.com (Felipe Balbi)
Date: Tue, 19 Nov 2013 14:16:17 -0600
Subject: [Inquiry] How to boot using USB device and configure PCI using
 OMAP4460/4470?
In-Reply-To: <CAB8gEUtYG9agU2i=fEKocfw1wjvBDfHvo5=fLNpABeNtFiXSxA@mail.gmail.com>
References: <CAB8gEUt-_-w4wJkdo3bH7qiLOaqFusfL85rs58n00twD1qpxLA@mail.gmail.com>
 <20131114154505.GC15835@saruman.home>
 <CAB8gEUtYG9agU2i=fEKocfw1wjvBDfHvo5=fLNpABeNtFiXSxA@mail.gmail.com>
Message-ID: <20131119201617.GC4715@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 09:47:42AM +0800, Maggie Mae Roxas wrote:
> Hi Felipe,
> Good morning.
> 
> Thank you very much for the feedback.
> 
> > all you need to do is write a flasher and a small "bootloader" which
> > knows about usb. ROM code can receive data via USB and jump to that
> > data's entry point.
> > It's all in the TRM.
> OK, I will look into this.
> However, it seems like this question (1) is not kernel-related.
> Can you direct me to the correct contact person for this?
> 
> > that's because OMAP4 doesn't have a PCI controller.
> But TI OMAP4470 Blaze Tablet 2 Development Platform contains PCI (miniPCIe).
> How is Blaze 2 tablet's kernel configured then..?

oh, that's a COM connector. It's used to interface with TI's WiLink
devices.  The actual bus there is SDIO.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/c29ac9a3/attachment.sig>
