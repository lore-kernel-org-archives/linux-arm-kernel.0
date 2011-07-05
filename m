From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 05 Jul 2011 16:19:05 +0900
Subject: [PATCH 7/7] ASoC: Samsung: Update DMA interface
In-Reply-To: <20110704170259.GC28726@opensource.wolfsonmicro.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<1309781915-31549-8-git-send-email-kgene.kim@samsung.com>
	<20110704170259.GC28726@opensource.wolfsonmicro.com>
Message-ID: <00bf01cc3ae3$d5a29150$80e7b3f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
Hi Mark,

Please refer to my other comment which includes block diagram, it can help
our understanding about current Samsung DMA usage.

> Two questions here:
> 
> - It looks like a lot of this code can be shared between all the drivers
>   using the dmaengine API.  Is there any reason not to factor it out?

Hmm...I'm not sure, but let us think/check your suggestions. Thanks :)

> - Should this not be adding a new driver for dmaengine based Samsung
>   CPUs?  The ifdefs are very big.

OK, we will try.

Grant, I think, Mark's suggestion can support multiple platform...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
