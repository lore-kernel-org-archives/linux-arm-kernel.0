From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 10 Jun 2016 12:29:15 +0200
Subject: [PATCH 0/3] clk: samsung: exynos5433: Add CLK_IGNORE_UNUSED flag
 and
In-Reply-To: <1465534592-18860-1-git-send-email-cw00.choi@samsung.com>
References: <1465534592-18860-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <575A967B.9080209@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2016 06:56 AM, Chanwoo Choi wrote:
> This patch-set add the CLK_IGNORE_UNUSED flag to the specific clocks because
> the specific clocks should remain the enable state. This patch-set support the
> PCIE (PCI Express), serial3(AUD Uart) device and fix the hang issue for
> suspend-to-ram.
> 
> Beomho Seo (1):
>   clk: samsung: exynos5433: Add CLK_IGNORE_UNUSED flag for AUD Uart
> 
> Jaehoon Chung (1):
>   clk: samsung: exynos5433: Add CLK_IGNORE_UNUSED flag to PCIE device
> 
> Jonghwa Lee (1):
>   clk: samsung: exynos5433: Add CLK_IGNORE_UNUSED flag to clocks occurring hang at sleep

I applied these patches, after slightly editing the descriptions.
I also tested with the audio subsystem patches on top of 4.7-rc1 tree
and with AUD UART enabled. Everything seems to be working fine, there
was no any "external abort" exceptions.

-- 
Thanks,
Sylwester
