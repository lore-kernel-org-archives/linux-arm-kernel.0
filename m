From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Sat, 16 Jul 2016 03:22:30 +0000
Subject: Memory and IO space Enabling different in x86 and ARM64
In-Reply-To: <7127812.WYSppNUyGc@wuerfel>
References: <8520D5D51A55D047800579B094147198258B9376@XAP-PVEXMBX01.xlnx.xilinx.com>
 <7127812.WYSppNUyGc@wuerfel>
Message-ID: <8520D5D51A55D047800579B094147198258B98B2@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: Memory and IO space Enabling different in x86 and ARM64
>
> On Friday, July 15, 2016 8:29:49 AM CEST Bharat Kumar Gogada wrote:
> > I observe that memory and IO space are enabled by BIOS in x86.
> >
> > In ARM64 we need to call pci_enable_device form End Point to enable
> these resources.
> >
> > Why the resource enablement is different in x86 and ARM64 ?
> >
> > Please correct me if my observation is wrong.
>
> This is a difference between systems with a BIOS and embedded systems
> with a plain bootloader that ignores PCI. On an ARM64 server system with
> UEFI you should expect the device to be usable too, but on an embedded
> system, Linux takes the role of the BIOS.
>
Thanks Arnd Bergmann



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
