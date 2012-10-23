From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 23 Oct 2012 21:03:01 +0900
Subject: [PATCH] ARM: dts: exynos4: Enable serial controllers on Origen and
 SMDKV310
In-Reply-To: <16890730.oeOgcP5xf2@flatron>
References: <1349701968-6675-1-git-send-email-t.figa@samsung.com>
 <1587144.mixS1B3zoJ@amdc1227>
 <10e401cdaae0$a17d44b0$e477ce10$%kim@samsung.com>
 <16890730.oeOgcP5xf2@flatron>
Message-ID: <01d201cdb116$59de2520$0d9a6f60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> However I think this should be considered a fix, because without it serial
> console on Origen and SMDKV310 will be broken.
> 
Well, I couldn't find any broken due to miss this for v3.7. I think, there
is no usage of serial controller in mainline for Origen and SMDKV310 now. So
this should be queued for -next. If not, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
