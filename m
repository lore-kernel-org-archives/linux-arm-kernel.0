From: wj_nwpu@163.com (wangjun)
Date: Tue, 11 Jan 2011 22:19:56 +0800 (CST)
Subject: about arm_add_memory
Message-ID: <7ce5e8c1.b773.12d757289fc.Coremail.wj_nwpu@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

in  /arch/arm/kernel/setup.c


static int __init arm_add_memory(unsigned long start, unsigned long size)
...
size -= start & ~PAGE_MASK;
bank->start = PAGE_ALIGN(start);
bank->size  = size & PAGE_MASK;
bank->node  = PHYS_TO_NID(start);
.....

what   size -= start & ~PAGE_MASK  to do ?
thanks!













-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110111/92fda902/attachment-0001.html>
