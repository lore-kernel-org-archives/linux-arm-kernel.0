From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 20 Apr 2015 14:10:22 -0700
Subject: [PATCH v2 1/6] arm64: Enable Hisilicon ARMv8 SoC family in
 Kconfig and defconfig
In-Reply-To: <1428916660-25910-2-git-send-email-bintian.wang@huawei.com>
 (Bintian Wang's message of "Mon, 13 Apr 2015 17:17:35 +0800")
References: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
 <1428916660-25910-2-git-send-email-bintian.wang@huawei.com>
Message-ID: <7hvbgqfqv5.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bintian Wang <bintian.wang@huawei.com> writes:

> This patch introduces ARCH_HISI to enable Hisilicon SoC family in
> Kconfig and defconfig.
>
> Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
> Reviewed-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> Reviewed-by: Wei Xu <xuwei5@hisilicon.com>

[...]

> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index be1f12a..36ebd9b 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -36,6 +36,7 @@ CONFIG_ARCH_MEDIATEK=y
>  CONFIG_ARCH_THUNDER=y
>  CONFIG_ARCH_VEXPRESS=y
>  CONFIG_ARCH_XGENE=y
> +CONFIG_ARCH_HISI=y

nit: please keep CONFIG_ARCH_* sorted alphabetically.

Thanks,

Kevin
