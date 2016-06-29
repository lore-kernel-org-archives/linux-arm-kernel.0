From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 29 Jun 2016 10:29:35 +0200
Subject: [PATCH v2] ARM: s3c64xx: Add missing head file
In-Reply-To: <1467187835-25660-1-git-send-email-wangkefeng.wang@huawei.com>
References: <577379DA.10902@samsung.com>
 <1467187835-25660-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <577386EF.1070400@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/2016 10:10 AM, Kefeng Wang wrote:
> The building reports warning after patch "arm: Remove unnecessary
> of_platform_populate with default match table",
> 
> "arch/arm/mach-s3c64xx/common.h:28:2: warning: 'struct device_node' declared inside parameter list"
> 
> Add the missing of.h for device_node struct in common.h, and kill common.h
> from arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c, because no function need it.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> 
> Hi Krzysztof, 
> 
> Thanks for your points, add "Reported-by" tag in v2, and Rob can directly
> pick it up if necessary.
> 
> Thanks,
> Kefeng
> 
>  arch/arm/mach-s3c64xx/common.h          | 1 +
>  arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
