From: sascha-ml-devel-openrd-google@silbe.org (Sascha Silbe)
Date: Thu, 1 Oct 2009 10:12:16 +0200
Subject: kirkwood openrd: random kernel crashes with git kernel
In-Reply-To: <200910010904.18923.dk-arm-linux@gmx.de>
References: <200910010904.18923.dk-arm-linux@gmx.de>
Message-ID: <20091001081216.GA4941@twin.sascha.silbe.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2009 at 09:04:18AM +0200, Dieter Kiermaier wrote:

> WARNING: at arch/arm/kernel/process.c:171 cpu_idle+0x74/0xbc()
> Modules linked in:
> [<c002a748>] (unwind_backtrace+0x0/0xd8) from [<c003931c>] 
> (warn_slowpath_common+0x4c/0x68)
> [<c003931c>] (warn_slowpath_common+0x4c/0x68) from [<c0026844>] 
> (cpu_idle+0x74/0xbc)
> [<c0026844>] (cpu_idle+0x74/0xbc) from [<c0008b2c>] 
> (start_kernel+0x22c/0x27c)
> [<c0008b2c>] (start_kernel+0x22c/0x27c) from [<00008034>] (0x8034)
Try the patch from [1], it works for me (uptime 5 days now without the 
message above).
Disclaimer: I know next to nothing about Linux internals, so can't judge 
the quality of the patch. Use at your own risk.


[1] http://patchwork.kernel.org/patch/40871/

CU Sascha

-- 
http://sascha.silbe.org/
http://www.infra-silbe.de/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 489 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091001/e932760f/attachment-0001.sig>
