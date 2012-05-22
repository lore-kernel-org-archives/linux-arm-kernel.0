From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Tue, 22 May 2012 15:25:25 -0700
Subject: [PATCH] ARM: BCMRING: fix IO mem static mapping
In-Reply-To: <4FA962D6.3030807@broadcom.com>
References: <4FA82414.7070407@broadcom.com>
 <201205072044.38612.arnd@arndb.de> <4FA962D6.3030807@broadcom.com>
Message-ID: <4FBC1255.7030200@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> The other question is about the multiplatform kernel I've recently worked
> on. bcmring is the only subarchitecture in Linux that puts header files
> in its own directory outside of the mach/*.h hierarchy, which gets in the
> way and is rather inconsistent. I've prepared a git branch to clean that
> up, see the "testing/bcmring" branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for this.
> I've also added a patch to clean up some API abuse for MMIO accesses
> that might otherwise cause problems. Can you test this branch and see
> if everything still works for you?

I verified that the changes work fine after I applied the IO mem mapping 
and UART patches. I also briefly looked into the changes and they seems 
good to me. Let me know if you want me to do a review.

Will these changes go to v3.5?

Regards,
JD

>
> 	Arnd
>
