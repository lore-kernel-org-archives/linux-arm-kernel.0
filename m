From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 16 Feb 2018 11:02:19 +0100
Subject: [PATCH 2/2] ARM: dts: rockchip: Fix DWMMC clocks
In-Reply-To: <cccc5187b9925bb7f025326220f75f9919d562c2.1518703554.git.robin.murphy@arm.com>
References: <74be71477b800f8a7b93a9e92ffeff9bf38c52ce.1518703554.git.robin.murphy@arm.com>
 <cccc5187b9925bb7f025326220f75f9919d562c2.1518703554.git.robin.murphy@arm.com>
Message-ID: <2207128.qcrQYv86Pa@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 15. Februar 2018, 15:05:54 CET schrieb Robin Murphy:
> Trying to boot an RK3328 box with an HS200-capable eMMC, I see said eMMC
> fail to initialise as it can't run its tuning procedure, because the
> sample clock is missing. Upon closer inspection, whilst the clock is
> present in the DT, its name is subtly incorrect per the binding, so
> __of_clk_get_by_name() never finds it. By inspection, the drive clock
> suffers from a similar problem, so has never worked properly either.
> 
> This error has propagated across the 32-bit DTs too, so fix those up.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

added apropriate Fixes-tags and applied as fix for 4.16


Thanks
Heiko
