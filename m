From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 30 Jan 2010 16:39:26 +0530
Subject: [PATCH 0/9] Initial multi-omap support for omap4
In-Reply-To: <20100130020036.10590.78028.stgit@baageli.muru.com>
References: <20100130020036.10590.78028.stgit@baageli.muru.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C0A68EB3@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,
> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Tony
> Lindgren
> Sent: Saturday, January 30, 2010 7:31 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-omap at vger.kernel.org
> Subject: [PATCH 0/9] Initial multi-omap support for omap4
> 
> Hi all,
> 
> These patches allow compiling in also omap4 into the multi-omap
> configuration. As I don't yet have omap4, I've only boot tested
> these on omap2 and omap3.
> 
> Somebody with an omap4 board please boot test these with the
> omap3_defconfig and see what happens.. You might want to enable
> DEBUG_LL and EARLY_PRINTK with earlyprintk on the cmdline too.
Looks like this series have some dependent series because it doesn't
apply on mainline.

So I tested this directly on linux-omap "multi-omap4" branch. It boots sufficiently
but doesn't proceed after "brd_init". Didn't get much time to debug so attached log

Regards,
Santosh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: omap3_defconfig.log
Type: application/octet-stream
Size: 10866 bytes
Desc: omap3_defconfig.log
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100130/4a7373c7/attachment-0001.obj>
