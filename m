From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 21 Apr 2018 19:05:14 +0200
Subject: [PATCH 01/61] ARM: plat-samsung: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-2-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-2-wsa+renesas@sang-engineering.com>
Message-ID: <20180421170514.qmklysbjrnkatns5@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 04:05:31PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  arch/arm/plat-samsung/adc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
