From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 17 May 2011 14:10:43 +0200
Subject: [PATCH 3/7] [media] s5p-fimc: Remove to support fimc for S5PC100
In-Reply-To: <002001cc1399$02964bb0$07c2e310$%kim@samsung.com>
References: <1305162674-25860-1-git-send-email-kgene.kim@samsung.com>
	<1305162674-25860-4-git-send-email-kgene.kim@samsung.com>
	<4DCBA717.3090307@samsung.com>
	<002001cc1399$02964bb0$07c2e310$%kim@samsung.com>
Message-ID: <4DD265C3.9040101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2011 09:15 AM, Kukjin Kim wrote:
> Sylwester Nawrocki wrote:
> 
>> Shouldn't there be some deprecation period for whole s5pc100 support
> removal ?
> 
> This is that. But I know, there is no time...
> 
>> It looks a bit rude to me that suddenly whole support for the SoC is
> vanished.
> 
> Hmm...what did you think about my previous comments: 'removing some
> "mach-s5pxxxx"s'?

I would expect one kernel release period of so notice for such a change.
But it doesn't have to be true in this specific case.

> 
>> I know at least one active user of mainline FIMC driver @ s5pc100.
> 
> Do you _really_ want to keep it in later mainline?

I don't personally have interest in maintaining this driver for s5pc100.
It just adds unnecessary complexity to my work and in fact I have limited
possibilities now to test the driver on s5pc100.
But if there are users and it really doesn't cost much to keep the support
for s5pc100 why bother to remove it?  Just to get rid of one mach-* directory ? 

> 
> I was not sure we should keep continually 6442 and C100 in mainline when I
> decided to removing 'mach-s5pxxxx'.

I really don't care about 6442, but what's the problem with s5pc100 ?
Is it being discontinued ? Or there is little users of it ?

I would much more like to see attempts to consolidate the code rather than
simply removing it.


Regards,
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
