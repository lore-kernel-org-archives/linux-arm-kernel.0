From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 23 May 2014 23:15:38 +0200
Subject: [PATCH v10 3/3] ARM: dts: Add initial device tree support for
 EXYNOS5410
In-Reply-To: <1400841343-6016-4-git-send-email-t.dakhran@samsung.com>
References: <1400841343-6016-1-git-send-email-t.dakhran@samsung.com>
 <1400841343-6016-4-git-send-email-t.dakhran@samsung.com>
Message-ID: <537FBA7A.3000605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tarek,

On 23.05.2014 12:35, Tarek Dakhran wrote:
> Add initial device tree nodes for EXYNOS5410 SoC and SMDK5410 board.
> 
> Signed-off-by: Tarek Dakhran <t.dakhran@samsung.com>
> Signed-off-by: Vyacheslav Tyrtov <v.tyrtov@samsung.com>
> ---
>  arch/arm/boot/dts/Makefile                |    1 +
>  arch/arm/boot/dts/exynos5410-smdk5410.dts |   82 ++++++++++++
>  arch/arm/boot/dts/exynos5410.dtsi         |  206 +++++++++++++++++++++++++++++
>  3 files changed, 289 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos5410-smdk5410.dts
>  create mode 100644 arch/arm/boot/dts/exynos5410.dtsi

Looks good. Hopefully we can have this patch applied soon, so it won't
get outdated again.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
