From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 28 Jan 2016 13:57:22 +0100
Subject: [PATCH v2] clk: Move vendor's Kconfig into CCF menu section
In-Reply-To: <1453971537-5510-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1453971537-5510-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <56AA1032.70001@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/01/16 09:58, James Liao wrote:
> Move all vendor's Kconfig into CCF menu section to prevent
> new drivers putting their Kconfig files in a wrong place.
> 
> Some Kconigs need to modify at the same time to avoid build

"Some Kconfigs need to be modified..." ?

> warnings.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---
> This patch is based on v4.5-rc1.
> 
> changes since v1:
> - Modify s3c24xx and samsung's Kconfig to avoid build warngings.
> 
>  arch/arm/mach-s3c24xx/Kconfig | 1 +
>  drivers/clk/Kconfig           | 8 +++-----
>  drivers/clk/samsung/Kconfig   | 1 -
>  3 files changed, 4 insertions(+), 6 deletions(-)

For the samsung code changes:

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

-- 
Thanks,
Sylwester
