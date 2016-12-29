From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 30 Dec 2016 00:14:11 +0100
Subject: 4.10-rc1 on Nokia N900: regression, WARN_ON() omap_l3_smx.c
Message-ID: <20161229231411.GA6865@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I forgot I had v4.10-rc1 running, and now I got warning on all the
consoles (hand-copied).


Unhandled fault: external abort on non-linefetch (0x1028) at
0xfa0ab060
...
Comm: kworker/0:0 Not tainted.
Workqueue: events musb_irq_work
...
PC is at musb_default_readb().
...
WARNING: CPU: 0 ... at drivers/bus/omap_l3_smx.c:166
omap3_l3_app_irq+0xcc/...
Tainted: GDW.

I do have patches to allow nfsroot over usb. But they worked ok in
v4.9... Does anyone see it, too?

Best regards,

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161230/ea397025/attachment.sig>
