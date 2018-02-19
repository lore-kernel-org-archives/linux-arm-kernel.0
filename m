From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Feb 2018 14:42:55 -0600
Subject: [PATCH 2/2] arm64: dts: rockchip: add a standalone version of
 the  rk3399 sapphire
In-Reply-To: <7102557.xWtZfjvKIZ@phil>
References: <CAAMcf8CY1m+998+GpD2wOfAZb=oZNkL2GqYu_o5piGEh76uoYw@mail.gmail.com>
 <3840224.sEPfbROKII@phil> <7102557.xWtZfjvKIZ@phil>
Message-ID: <20180219204255.cvn2z5dw5ritjkod@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 09:16:17AM +0100, Heiko Stuebner wrote:
> While the sapphire board is a system-on-module and mostly used with the
> excavator baseboard, it is also possible to use it standalone without
> any base. So add a board-variant for this type.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.txt |  4 ++++
>  arch/arm64/boot/dts/rockchip/Makefile              |  1 +
>  arch/arm64/boot/dts/rockchip/rk3399-sapphire.dts   | 12 ++++++++++++
>  3 files changed, 17 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dts

Reviewed-by: Rob Herring <robh@kernel.org>
