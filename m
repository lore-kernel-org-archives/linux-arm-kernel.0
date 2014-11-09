From: jan.kiszka@web.de (Jan Kiszka)
Date: Sun, 09 Nov 2014 20:35:49 +0100
Subject: AMR: sun7i: CPU hotplug support?
Message-ID: <545FC215.7010802@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

did anyone already happen to look into enabling CPU hotplug for the
Allwinner A20 in upstream? I'm currently running the sunxi-next branch
on Banana Pi, and echo 0 > .../cpu1/online just hangs the system. The
old 3.4 LeMaker kernel works fine in this regard. I can try to look into
details and port things over, just want to avoid duplicate efforts.

Thanks,
Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141109/8916a565/attachment.sig>
