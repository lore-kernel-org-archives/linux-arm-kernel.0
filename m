From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 26 Sep 2011 13:22:54 +0900
Subject: Samsung GPIO changes break boot on Cragganmore
In-Reply-To: <20110922135351.GC5173@opensource.wolfsonmicro.com>
References: <20110922135351.GC5173@opensource.wolfsonmicro.com>
Message-ID: <00d301cc7c03$f6813230$e3839690$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Hi,
> 
> Something in the recent GPIO changes have broken the boot for me on
> Cragganmore (S3C6410 based) systems.  The boot dies before any console
> output is produced so it's hard to isolate exactly what went wrong but
> backing out:
> 
>    5ec7414 ARM: SAMSUNG: Remove useless Samsung GPIO related CONFIGs
>    7c15788 ARM: SAMSUNG: Update the name of regarding Samsung GPIO
>    bedcda6 gpio/samsung: gpio-samsung.c to support Samsung GPIOs
> 
> fixes the system boot for me.  The diff is rather substantial so it's
> hard to check by eyeball unfortunately.
> 
Hi Mark,

Oh, ok. Let me test on SMDK6410 and will fix soon.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
