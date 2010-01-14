From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 14 Jan 2010 14:42:11 +0900
Subject: [PATCH] ARM: SAMSUNG: Add system.h file
In-Reply-To: <20100114053243.GM3738@trinity.fluff.org>
References: <1263431714-2922-1-git-send-email-kgene.kim@samsung.com>
	<20100114053243.GM3738@trinity.fluff.org>
Message-ID: <000d01ca94dc$51d1f270$f575d750$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Ben Dooks wrote:
> On Thu, Jan 14, 2010 at 10:15:14AM +0900, Kukjin Kim wrote:
> > This patch adds system.h file into plat-samsung.
> 
> My worries here are that this is an empty file that is not currently
> useful for any of the extant Samsung SoC in-kernel implementations (they
> all have something in their own system.h files) and that if any of the new
> architectures decide they need arch_reset() then they may end up overriding
> this anyway.

Hi Ben,

Thanks for your comments.
The system.h file is moved to mach-s5p6440/include/mach, in my [PATCH v5 1/8
RE-SEND] patch.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
System LSI Division, SAMSUNG ELECTRONICS CO., LTD.
