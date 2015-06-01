From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 01 Jun 2015 20:34:26 +0900
Subject: [PATCH 0/6] Exynos SYSMMU (IOMMU) dts and arch updates
In-Reply-To: <1433153450-3680-1-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
 <1433153450-3680-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <556C4342.6060506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 01.06.2015 o 19:10, Marek Szyprowski pisze:
> Hello,
> 
> Main changes for Exynos SYSMMU (IOMMU) driver has been finally scheduled
> for merging - see
> https://git.kernel.org/cgit/linux/kernel/git/joro/iommu.git/commit/?h=next
> In meantime there have been quite a lot of changes related to Exynos DTS
> files queued for merging and my patches don't apply anymore. To ease
> merge process I've decided to rebased all Exynos SYSMMU dts changes onto
> latest exynos next tree from: https://github.com/krzk/linux dt-for-next
> 
> While rebasing I've fixes a few spotted issues: some nodes still used
> old 'samsung,power-domain' properties (now replaced with 'power-domains')
> and added properties to jpeg codec merged recently.
> 

Thanks for rebasing this stuff.

I picked whole patchset with Javier's tested-by. I'll send it to Kukjin
later or directly to arm-soc (depending what will happen with last pull
request).

Kukjin, you mentioned that you will do something with this patchset the
previous weekend. Since then nothing happened so I am not sure what are
your plans... Can you share them? Do you want to pick it by yourself, do
you have any comments or maybe you need something from our side? (I
checked the patches and they look fine)

Best regards,
Krzysztof
