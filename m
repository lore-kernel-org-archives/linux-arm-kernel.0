From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Feb 2012 12:33:32 +0000
Subject: [PATCH 3/7] rtc: sa1100: use ioremap to map registers
In-Reply-To: <1329815096-6200-4-git-send-email-haojian.zhuang@marvell.com>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
 <1329815096-6200-4-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <201202221233.32766.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 February 2012, Haojian Zhuang wrote:
> 
> Add resource definition of sa1100 rtc. And use ioremap to map rtc
> registers to avoid including address definition of rtc register.
> So the same driver could be shared on sa1100/pxa/mmp series.
> 
> Since there's two RTC wrappers on RTC module among PXA27x/PXA3xx/PXA95x,
> keep treating the two wrappers as two RTC devices will result issues
> of registering platform device. So only keep one RTC wrapper in
> these silicons.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

I believe I reviewed this in the past and it looks good to me in its
present version, so

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
