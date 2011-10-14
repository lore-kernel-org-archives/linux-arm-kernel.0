From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 14 Oct 2011 11:14:25 +0200
Subject: [Linaro-mm-sig] [PATCH 8/9] ARM: integrate CMA with DMA-mapping
	subsystem
In-Reply-To: <4E97BB8E.3060204@gmail.com>
References: <1317909290-29832-1-git-send-email-m.szyprowski@samsung.com>
	<1317909290-29832-10-git-send-email-m.szyprowski@samsung.com>
	<4E97BB8E.3060204@gmail.com>
Message-ID: <013701cc8a51$ab1a3fb0$014ebf10$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, October 14, 2011 6:33 AM Subash Patel wrote:

> Hi Marek,
> 
> As informed to you in private over IRC, below piece of code broke during
> booting EXYNOS4:SMDKV310 with ZONE_DMA enabled.

Right, I missed the fact that ZONE_DMA can be enabled but the machine does not
provide specific zone size. I will fix this in the next version. Thanks for 
pointing this bug!

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
