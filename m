From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 26 Jan 2017 22:11:20 +0200
Subject: [PATCH v2 7/8] mfd: exynos-lpass: Add missing remove() function
In-Reply-To: <1485419634-28331-8-git-send-email-m.szyprowski@samsung.com>
References: <1485419634-28331-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170126083405eucas1p29a888fa3896e2bd131e23585f7d033d9@eucas1p2.samsung.com>
 <1485419634-28331-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170126201120.gz2mv7uduupj7uqs@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 09:33:53AM +0100, Marek Szyprowski wrote:
> Disable device on driver remove and release allocated regmap.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/mfd/exynos-lpass.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

A Suggested-by would be welcomed but beside that thanks for change:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
