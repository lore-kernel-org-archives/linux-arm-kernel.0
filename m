From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 24 Aug 2015 12:32:17 +0530
Subject: [PATCH-v3] mfd: 88pm80x: Add 88pm860 chip type support
In-Reply-To: <1437393151-5362-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437393151-5362-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <55DAC179.2060802@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 20 July 2015 05:22 PM, Vaibhav Hiremath wrote:
> Add chip identification support for 88PM860 device
> to the pm80x_chip_mapping table.
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>   drivers/mfd/88pm80x.c       | 2 ++
>   include/linux/mfd/88pm80x.h | 1 +
>   2 files changed, 3 insertions(+)
>

Mark,

Last update/understanding which I have on this patch is,

Lee is OK with taking this patch from regulator tree.
Lee please let me know if you think otherwise.

With this patch in, the build dependency will go away.

Request to pick this patch into your topic/88pm800 branch and run build
test.

Thanks,
Vaibhav
