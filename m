From: dianders@chromium.org (Doug Anderson)
Date: Fri, 25 Jul 2014 15:12:01 -0700
Subject: [PATCH v3 7/8] ARM: dts: add rk3288 evaluation board
In-Reply-To: <1406324980-2450-8-git-send-email-heiko@sntech.de>
References: <1406324980-2450-1-git-send-email-heiko@sntech.de>
 <1406324980-2450-8-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=Xi8Zu-T+fEaigRRTOex2t_Zj7f6inmfWU8WMHfN-MSjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Fri, Jul 25, 2014 at 2:49 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> There exist 2 variants using either the act8846 or rk808 as pmic, while the
> rest of the board stays the same.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/boot/dts/rk3288-evb-act8846.dts | 134 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/rk3288-evb-rk808.dts   |  18 +++++
>  arch/arm/boot/dts/rk3288-evb.dtsi        |  74 +++++++++++++++++
>  3 files changed, 226 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3288-evb-act8846.dts
>  create mode 100644 arch/arm/boot/dts/rk3288-evb-rk808.dts
>  create mode 100644 arch/arm/boot/dts/rk3288-evb.dtsi

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
