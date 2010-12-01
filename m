From: weizhong@broadcom.com (Wei Zhong)
Date: Wed, 1 Dec 2010 10:50:17 -0800
Subject: kfree in clkdev_drop()
Message-ID: <1B26E9BD9AEAAE46A7BDAD7754D0432CDE18D6CB6A@SJEXCHCCR02.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

For kernel 2.6.36, clkdev_drop() in arch/arm/common/clkdev.c, shouldn't it be

kfree(container_of(cl, struct clk_lookup_alloc, cl));

Thanks,
Wei
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101201/94e8dd4f/attachment-0001.html>
