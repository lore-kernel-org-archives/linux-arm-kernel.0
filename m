From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Fri, 28 Jun 2013 14:14:54 +0800
Subject: FW: Arch/arm/msm/memory.c:reserve_memory_for_mempools( )
Message-ID: <35FD53F367049845BC99AC72306C23D19441BF586A@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sboy,

I don't know who should I send this mail to .
If you are not the right person, please forward To the right responsible person , Thank you !

I have a question about msm kernel code :

File: Arch/arm/msm/memory.c

reserve_memory_for_mempools()
it call memblock_remove() directly,
I think it's not safe sometimes ,
Should use arm_memblock_steal() function or some other similar Function to make sure the removed memory is not reserved by memblock driver, In case the removed memory is reserved by some other driver.


Thanks 


Yalin.Wang
Software Engineer
OS Kernel&Graphics
?
Sony Mobile Communications
Tel: +86 10 5966 9819
Phone: 18610323092
Address: No.16 Guangshun South Street, Chaoyang, Beijing, P.R.C.

sonymobile.com
??
