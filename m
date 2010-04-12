From: saeed.bishara@gmail.com (saeed bishara)
Date: Mon, 12 Apr 2010 10:56:06 +0300
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <alpine.LFD.2.00.1004111033010.7232@xanadu.home>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
	<1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1003261144020.694@xanadu.home>
	<alpine.LFD.2.00.1004111033010.7232@xanadu.home>
Message-ID: <w2hc70ff3ad1004120056za5960033ja97e2046d17a7f24@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nico, thanks for the patch.
I've ported it for 2.6.32.9 kernel, can you have a look at the attached patch?

saeed

On Sun, Apr 11, 2010 at 5:42 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> Russell,
>
> Do you have concerns about patch #6007/1 that I might have missed?
> Otherwise it would be nice to move it towards mainline for ARMv6
> targets to work properly with highmem at last.
>
>
> Nicolas
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-fix-highmem-with-VIPT-cache-and-DMA.patch
Type: text/x-patch
Size: 8951 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100412/68878bb9/attachment-0001.bin>
