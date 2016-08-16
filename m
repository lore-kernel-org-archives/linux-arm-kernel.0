From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 21:26:22 +0200
Subject: [PATCH 02/10] ARM: EXYNOS: Remove calls to
 of_genpd_get_from_provider()
In-Reply-To: <1471340976-5379-3-git-send-email-jonathanh@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
 <1471340976-5379-3-git-send-email-jonathanh@nvidia.com>
Message-ID: <20160816192622.GA18141@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 10:49:28AM +0100, Jon Hunter wrote:
> Update the EXYNOS PM domain code to use the of_genpd_add_subdomain()
> and remove any calls to of_genpd_get_from_provider().
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/samsung/pm_domains.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)

Looks correct:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

I understand this will go along with patch #1 to PM tree. There might be
some more commits around Exynos PM domain code coming soon. To avoid possible
conflicts, could you put it in a separate branch with patch #1 so a
stable tag could be easily created? I don't see direct necessity now but
it might be needed quite soon.

Best regards,
Krzysztof
