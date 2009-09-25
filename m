From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 25 Sep 2009 09:30:05 +0800
Subject: About ARM TCM patch
Message-ID: <4ABC1D1D.6050506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear ML,

I read the TCM patch from http://lwn.net/Articles/353032/

It said:
Code executing inside the ITCM does not "see" any MMU mappings
and e.g. register accesses must be made to physical addresses.

I am doubt it is correctly for all systems, at my SoC 
platform(arm1136JF, v6), the situation is difference.

1. After MMU open, the code running at ITCM can't see physical address 
for register.

2. After MMU open, the code can't run at physical addressed ITCM.

-- 
Best regards,
Peter Chen
