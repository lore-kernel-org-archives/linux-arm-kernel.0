From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 2 Oct 2014 15:58:41 +0900
Subject: [PATCH 0/2] ARM: dts: Add new board dts file for Exynos3250-based
 Rinato board
In-Reply-To: <1412075245-5763-1-git-send-email-cw00.choi@samsung.com>
References: <1412075245-5763-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <CAH9JG2WptOhTSfgn8Vz5BMHb5-ZgPKwzJsAMv0r8_Nm2JKMWSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ ARM maintainers.

It's Gear 2 board support.

Thank you,
Kyungmin Park

On Tue, Sep 30, 2014 at 8:07 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patchset adds new board dts file for Samsung Rinato board (Gear 2) which
> is based on Exynos3250 SoC and adds sleep mode pin configuration using pinctrl
> subsystem to reduce leakage power-consumption in sleep state.
>
> This patchset is based on linux-samsung.git (for-next branch).
>
> Chanwoo Choi (2):
>   ARM: dts: Add board dts file for Exynos3250-based Rinato board
>   ARM: dts: Add sleep mode pin configuration for exynos3250-rinato
>
>  arch/arm/boot/dts/Makefile                |   3 +-
>  arch/arm/boot/dts/exynos3250-pinctrl.dtsi |  16 +
>  arch/arm/boot/dts/exynos3250-rinato.dts   | 595 ++++++++++++++++++++++++++++++
>  3 files changed, 613 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/exynos3250-rinato.dts
>
> --
> 1.8.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
