From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 26 Apr 2014 02:40:39 +0200
Subject: [PATCHv4 1/7] ARM: EXYNOS: Add Exynos3250 SoC ID
In-Reply-To: <1398388572-30239-2-git-send-email-cw00.choi@samsung.com>
References: <1398388572-30239-1-git-send-email-cw00.choi@samsung.com>
 <1398388572-30239-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <535B0087.3000908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On 25.04.2014 03:16, Chanwoo Choi wrote:
> This patch add Exynos3250's SoC ID. Exynos 3250 is System-On-Chip(SoC) that
> is based on the 32-bit RISC processor for Smartphone. Exynos3250 uses Cortex-A7
> dual cores and has a target speed of 1.0GHz.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>   arch/arm/mach-exynos/Kconfig             | 22 ++++++++++++++++++++++
>   arch/arm/mach-exynos/exynos.c            |  2 ++
>   arch/arm/plat-samsung/include/plat/cpu.h | 10 ++++++++++
>   3 files changed, 34 insertions(+)

You can add my

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
