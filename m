From: bill_carson@126.com (rocky)
Date: Sat, 02 Apr 2011 03:59:14 -0000
Subject: cachepolicy on arm UP/SMP
Message-ID: <163eed8.b6ba.12f1441357c.Coremail.bill_carson@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all

I am a little confused about arm cachepolicy for UP/SMP.

in arch/arm/mm/mmu.c
for UP , default cache policy is CPOLICY_WRITEBACK;
while for SMP, cache policy is overrided with  WRITEALLOC.

why does SMP cannot use WRITEBACK?
It is about coherency issue?

Please give me some tips.
thanks

rocky







-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110402/a8adfc37/attachment-0001.html>
