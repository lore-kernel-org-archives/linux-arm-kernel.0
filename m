From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 23 Dec 2010 15:02:31 +0100
Subject: Last OMAP4 hwmod data cleanup for 2.6.38
Message-ID: <4D135677.1080200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

The merge of both SDMA series from Manju and SR series from Thara 
changed the expected order of the hwmod data structures for OMAP4.
In order to have a clean base for 2.6.38, and to avoid starting 2.6.39 
with a cleanup patch again, I'd like to fix that right now.
Even if, I do agree, this is not a big deal.

I squeezed the 3 original small fixes I did (SDMA, SR and alignment) 
into one to avoid overloading your mailbox 2 days before Xmas.

The patch will be available here, based on omap-for-linus.
git://gitorious.org/omap-pm/linux.git for_2.6.38/hwmod_fixes

It should not affect any functionality, and it is boot tested on 
OMAP4430/sdp.

Thanks,
Benoit
