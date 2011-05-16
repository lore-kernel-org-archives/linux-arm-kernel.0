From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 16 May 2011 16:15:13 +0900
Subject: [PATCH 3/7] [media] s5p-fimc: Remove to support fimc for S5PC100
In-Reply-To: <4DCBA717.3090307@samsung.com>
References: <1305162674-25860-1-git-send-email-kgene.kim@samsung.com>
	<1305162674-25860-4-git-send-email-kgene.kim@samsung.com>
	<4DCBA717.3090307@samsung.com>
Message-ID: <002001cc1399$02964bb0$07c2e310$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Hi Kukjin,
> 
Hi,

> Shouldn't there be some deprecation period for whole s5pc100 support
removal ?

This is that. But I know, there is no time...

> It looks a bit rude to me that suddenly whole support for the SoC is
vanished.

Hmm...what did you think about my previous comments: 'removing some
"mach-s5pxxxx"s'?

> I know at least one active user of mainline FIMC driver @ s5pc100.

Do you _really_ want to keep it in later mainline?

I was not sure we should keep continually 6442 and C100 in mainline when I
decided to removing 'mach-s5pxxxx'.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
