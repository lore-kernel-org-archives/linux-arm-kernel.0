From: k.lewandowsk@samsung.com (Karol Lewandowski)
Date: Tue, 31 Jan 2012 17:41:52 +0100
Subject: [PATCH v2] ARM: Exynos4: Add cpu-offset property in gic device
 tree node
In-Reply-To: <1328023789-4672-1-git-send-email-thomas.abraham@linaro.org>
References: <1328023789-4672-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4F2819D0.7090002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.01.2012 16:29, Thomas Abraham wrote:
> Commit db0d4db22a78 ('ARM: gic: allow GIC to support non-banked setups)
> requires a cpu-offset property to be specified for non-banked gic
> controllers, which is the case for Exynos4.
>
> Reported-by: Karol Lewandowski<k.lewandowski@samsung.com>

( Minor note - my email address lacks 'i' at the end, i.e. it's
   k.lewandowsk@ :)

> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
> ---
> This patch solves the issue of boot failure with SMP enabled kernel for
> Exynos4 device tree enabled machine.

Tested-by: Karol Lewandowski <k.lewandowsk@samsung.com>

Thanks!
