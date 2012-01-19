From: b32955@freescale.com (Huang Shijie)
Date: Thu, 19 Jan 2012 16:27:59 +0800
Subject: [PATCH resent v2 1/2] ioport : add DEFINE_RES_DMA_SIZE_NAMED macro
In-Reply-To: <4F17D2ED.6090502@freescale.com>
References: <1326959620-25920-1-git-send-email-b32955@freescale.com>
 <1326959620-25920-2-git-send-email-b32955@freescale.com>
 <20120119081427.GF2247@S2101-09.ap.freescale.net>
 <4F17D2ED.6090502@freescale.com>
Message-ID: <4F17D40F.3080803@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Hi Shawn:
>> I'm not sure the patch is welcomed.  You may want to just use
>> DEFINE_RES_NAMED for such cases.
> I ever wanted to use DEFINE_RES_NAMED.
sorry. I misunderstood your meaning.

I think it's better to add a new macro. use DEFINE_RES_NAMED is not proper.

Best Regards
Huang Shijie


> But it seems i have to change some other 
> code(/arch/arm/plat-samsung/devs.c).
>
> Anyway, if someone do not like this macro. I can change it too.
>
> Best Regards
> Huang Shijie
>
