From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 13 Mar 2014 16:33:57 +0100
Subject: [PATCH v5 2/3] ARM: dts: add dts files for exynos5260 SoC
In-Reply-To: <1394637394-3960-3-git-send-email-rahul.sharma@samsung.com>
References: <1394637394-3960-1-git-send-email-rahul.sharma@samsung.com>
 <1394637394-3960-3-git-send-email-rahul.sharma@samsung.com>
Message-ID: <5321CFE5.2000907@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12.03.2014 16:16, Rahul Sharma wrote:
> The patch adds the dts files for exynos5260.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> ---
>   arch/arm/boot/dts/exynos5260-pinctrl.dtsi |  574 +++++++++++++++++++++++++++++
>   arch/arm/boot/dts/exynos5260.dtsi         |  400 ++++++++++++++++++++
>   2 files changed, 974 insertions(+)
>   create mode 100644 arch/arm/boot/dts/exynos5260-pinctrl.dtsi
>   create mode 100644 arch/arm/boot/dts/exynos5260.dtsi
>

[snip]


> +		mmc_0: mmc0 at 12140000 {

Node names should specify type of the device, so unit-specific IDs 
should be avoided. Please simply use mmc at 12140000. The same comment for 
remaining MMC nodes below.

Best regards,
Tomasz
