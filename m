From: risingsunxy@googlemail.com (Xu Yang)
Date: Mon, 14 Sep 2009 15:05:30 +0200
Subject: bus_id in linux2.6.30
Message-ID: <ab40e9c0909140605w340fb646t163a6bc0687751b1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

in kernel 2.6.30,  struct device, there is no member bus_id any more.
but in the drivers for the older version 2.6.29 for example, this
bus_id is still used.

I found a patch

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1fa5ae857bb14f6046205171d98506d8112dd74e

which can get rid of the bus_id.

after I check the kernel source, I found that in the 2.6.30.5 it seems
that this patch is already applied.

does this mean we can just directly delete the bus_id used in the
drivers for the older version kernel?

thanks,

Best regards,

Yang
