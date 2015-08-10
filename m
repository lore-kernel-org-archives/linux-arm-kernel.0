From: kgene@kernel.org (Kukjin Kim)
Date: Mon, 10 Aug 2015 11:04:25 +0900
Subject: [GIT PULL] Samsung mach fixes for 4.2
In-Reply-To: <1439171530-971-1-git-send-email-k.kozlowski@samsung.com>
References: <1439171530-971-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <040901d0d310$e233fde0$a69bf9a0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc guys,

Can you please pull this into arm-soc fixes for v4.2 directly?
I don't have other samsung fixes in my tree at this moment.

Thanks,
Kukjin

Krzysztof Kozlowski wrote:
> 
> Dear Kukjin,
> 
> Please find latest two fixes for v4.2 cycle. You can find more detailed
> description with the tag.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/krzk/linux.git tags/samsung-mach-fixes-4.2
> 
> for you to fetch changes up to 3e9f798784b30293012682021d5a0352f78658b8:
> 
>   ARM: EXYNOS: fix double of_node_put() on error path (2015-07-31 10:12:17 +0900)
> 
> ----------------------------------------------------------------
> Two fixes for bugs in Exynos power domain error exit path:
> 1. kfree() of read-only memory (name of power domain returned
>    by kstrdup_const()),
> 2. Doubled of_node_put() leading to invalid ref count for OF node.
> 
> ----------------------------------------------------------------
> Vladimir Zapolskiy (2):
>       ARM: EXYNOS: Fix potentian kfree() of ro memory
>       ARM: EXYNOS: fix double of_node_put() on error path
> 
>  arch/arm/mach-exynos/pm_domains.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
