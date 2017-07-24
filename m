From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 24 Jul 2017 06:49:25 +0200
Subject: [PATCH] soc/samsung: use kbasename instead of open coding
In-Reply-To: <20170718214339.7774-50-robh@kernel.org>
References: <20170718214339.7774-50-robh@kernel.org>
Message-ID: <20170724044925.GA20898@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 04:43:30PM -0500, Rob Herring wrote:
> In preparation to not store the full path of nodes in full_name, use
> kbasename instead as it will work either with the full path or not.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> ---
>  drivers/soc/samsung/pm_domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks, applied, with slightly changed title.

Best regards,
Krzysztof
