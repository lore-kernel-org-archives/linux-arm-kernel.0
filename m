From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Apr 2014 10:11:57 +0200
Subject: [PATCHv2 3/8] ARM: EXYNOS: Add IO mapping for PMU of Exynos3250
In-Reply-To: <1397527192-21988-4-git-send-email-cw00.choi@samsung.com>
References: <1397527192-21988-1-git-send-email-cw00.choi@samsung.com>
 <1397527192-21988-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <4788081.xvaJfdGTMu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 April 2014 10:59:47 Chanwoo Choi wrote:
> This patch add memory mapping for PMU (Power Management Unit) which is used
> for power control of Exynos3250.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Arnd Bergmann suggested that need proper driver instead of static memory mapping.
> As Chanho Park reply[2], Sachin Kamat already posted the DT support patch[1]
> for memory mapping for SYSRAM.
> [1] http://www.spinics.net/lists/linux-samsung-soc/msg27647.html
> [2] https://lkml.org/lkml/2014/4/10/161
> 
> So, I'm going to re-implement following patch related to static memory mapping
> after merged Sachin Kamat patch[1].
>   ARM: EXYNOS: Add IO mapping for PMU of Exynos3250

I don't think we have a patch for the PMU yet, Sachin was looking at the SYSRAM
only.

	Arnd
