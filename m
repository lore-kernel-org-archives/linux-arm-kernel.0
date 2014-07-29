From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 30 Jul 2014 08:02:27 +0900
Subject: [PATCH 0/3] ARM: dts: Add TMU dt node and missing data for
 Exynos3250
In-Reply-To: <1406600232-31033-1-git-send-email-cw00.choi@samsung.com>
References: <1406600232-31033-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <53D82803.9060804@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/14 11:17, Chanwoo Choi wrote:
> This patchset add TMU (Thermal Management Unit) dt node and missing pinctrl
> property of uart0/1. Also, this patchset remove duplcate 'interrupt-parent'
> property for code clean.
>
> Chanwoo Choi (3):
>    ARM: dts: Add TMU dt node to monitor the temperature for Exynos3250
>    ARM: dts: Remove duplicate 'interrput-parent' property for Exynos3250
>    ARM: dts: Add missing pinctrl for uart0/1 for Exynos3250
>
>   arch/arm/boot/dts/exynos3250.dtsi | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>
Applied this whole series, thanks.

- Kukjin
