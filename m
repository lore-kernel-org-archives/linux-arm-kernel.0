From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 20 Feb 2010 14:00:38 +0530
Subject: [PATCH 00/11] omap updates for 2.6.34, part 4
In-Reply-To: <20100219232648.10559.380.stgit@baageli.muru.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C417FF19@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony, 

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Tony
> Lindgren
> Sent: Saturday, February 20, 2010 5:00 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-omap at vger.kernel.org
> Subject: [PATCH 00/11] omap updates for 2.6.34, part 4
> 
> Hi all,
> 
> Here are few USB platform init patches that have been already
> posted to linux-usb and linux-omap and have been sitting in for-next.
> 
> Posting them one more time to make sure people on linux-arm-kernel
> have seen these too.
> 
> Regards,
> 
> Tony
> 
> ---
> 
> Felipe Balbi (7):
>       arm: omap: musb: ioremap only what's ours
>       omap: musb: remove unused data
>       arm: omap: musb: we can use clk framework
>       omap: musb: remove unused soft_con field
>       omap: musb: remove unused dma data
>       omap: musb: remove unnecessary return
>       omap: musb: get rid of dyn_fifo
> 
> Maulik Mankad (4):
>       USB: Add empty functions in otg.h
>       omap: musb: Remove #ifdef from board-omap3evm.c
>       omap: musb: Pass board specific data from board file
>       omap: musb: Add USB support to 4430 SDP board file
>
We need attached patch to keep multi-omap build booting on omap4
on top of this series.

Regards,
Santosh

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-omap4-multi-omap-Allow-build-to-work.patch
Type: application/octet-stream
Size: 1407 bytes
Desc: 0001-omap4-multi-omap-Allow-build-to-work.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100220/136d9d16/attachment.obj>
