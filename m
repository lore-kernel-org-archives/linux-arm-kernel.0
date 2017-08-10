From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 10 Aug 2017 07:53:00 +0200
Subject: [PATCH v8 4/5] clk: samsung: exynos-audss: Use local variable
 for controller's device
In-Reply-To: <1502274907-11931-5-git-send-email-m.szyprowski@samsung.com>
References: <1502274907-11931-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170809103514eucas1p11fb5d1af243e882a5d51a25956d24a19@eucas1p1.samsung.com>
 <1502274907-11931-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170810055300.GB3268@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 09, 2017 at 12:35:06PM +0200, Marek Szyprowski wrote:
> Store pointer to the controller's device in local variable to avoid
> extracting it from platform device in each call. This will also simplify
> code in the future, when runtime PM support is added.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos-audss.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
