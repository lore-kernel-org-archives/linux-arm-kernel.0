From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 13 Oct 2014 14:00:23 +0900
Subject: [PATCHv2 0/2] ARM: dts: Add new board dts file for
 Exynos3250-based Rinato board
In-Reply-To: <1412721939-10615-1-git-send-email-cw00.choi@samsung.com>
References: <1412721939-10615-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <543B5C67.4080303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

Could you please review this patchset?

Best Regards,
Chanwoo Choi

On 10/08/2014 07:45 AM, Chanwoo Choi wrote:
> This patchset adds new board dts file for Samsung Rinato board (Gear 2) which
> is based on Exynos3250 SoC and adds sleep mode pin configuration using pinctrl
> subsystem to reduce leakage power-consumption in sleep state.
> 
> This patchset is based on linux-samsung.git (for-next branch).
> 
> Changes from v1:
> - Remove useless brace
> - Remove unneeded 'regulators' keyword
> - Consolidate memory information in one entry
> 
> Chanwoo Choi (2):
>   ARM: dts: Add board dts file for Exynos3250-based Rinato board
>   ARM: dts: Add sleep mode pin configuration for exynos3250-rinato
> 
>  arch/arm/boot/dts/Makefile                |   3 +-
>  arch/arm/boot/dts/exynos3250-pinctrl.dtsi |  16 +
>  arch/arm/boot/dts/exynos3250-rinato.dts   | 586 ++++++++++++++++++++++++++++++
>  3 files changed, 604 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/exynos3250-rinato.dts
> 
