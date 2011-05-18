From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 May 2011 17:53:22 +0900
Subject: [PATCH 0/7] ARM: Removing ARCH_S5PC100
In-Reply-To: <9ffr5a$esl6ci@out1.ip06ir2.opaltelecom.net>
References: <1305162674-25860-1-git-send-email-kgene.kim@samsung.com>
	<9ffr5a$esl6ci@out1.ip06ir2.opaltelecom.net>
Message-ID: <001401cc1539$0c267d70$24737850$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nick Pelling wrote:
> 
> At 10:11 12/05/2011 +0900, Kukjin Kim wrote:
> >This patch remvoes mach-s5pc100 directory for ARCH_S5PC100 in arch/arm.
> >If any problems, please let me know immediately.
> 
> Yes, this is a *big* problem for me as I'm actively working on
mach-s5pc100.
> 
> Unless you happen to know differently, the S5PC100 is still in mass
> production, and the security cameras my company make all use the
> S5PC100. There are also a number of other embedded modules currently
> in production based on the S5PC100.
> 
> What reason would you have for removing mach-s5pc100 from Linux?

Thanks for your opinion :)

Yes, I think it's rather premature to decide it at this time.
So this is dropped now and will merge with other samsung stuff next time ;)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
