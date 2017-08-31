From: robh@kernel.org (Rob Herring)
Date: Thu, 31 Aug 2017 16:04:21 -0500
Subject: [PATCH v2 2/2] ARM: dts: rockchip: Add rk3288 vyasa board
In-Reply-To: <1503742164-3926-1-git-send-email-jteki@openedev.com>
References: <1503742164-3926-1-git-send-email-jteki@openedev.com>
Message-ID: <20170831210421.l2zmpexisagoxdks@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 26, 2017 at 03:39:24PM +0530, Jagan Teki wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> This patch adds initial support for rk3288 based
> Vyasa board, which is made by Amarula Solutions.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - Added entry in Documentation/devicetree/bindings/arm/rockchip.txt
> 
>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>  arch/arm/boot/dts/Makefile                         |   3 +-
>  arch/arm/boot/dts/rk3288-vyasa.dts                 | 312 +++++++++++++++++++++
>  3 files changed, 318 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/rk3288-vyasa.dts

Acked-by: Rob Herring <robh@kernel.org>

I assume the regulator node names are consistent with other platforms, 
but at some point please fix them to be lowercase and not use '_'. IOW, 
build the dtbs with "W=2" and fix the warnings.

Rob
