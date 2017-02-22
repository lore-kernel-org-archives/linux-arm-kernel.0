From: robh@kernel.org (Rob Herring)
Date: Wed, 22 Feb 2017 09:10:16 -0600
Subject: [PATCH 7/7] ARM: rockchip: reanme RK1108 to RV1108
In-Reply-To: <1486984234-32693-1-git-send-email-andy.yan@rock-chips.com>
References: <1486983566-32265-1-git-send-email-andy.yan@rock-chips.com>
 <1486984234-32693-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <20170222151016.bsiyv2j5sg2qvkhm@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 07:10:34PM +0800, Andy Yan wrote:
> Rockchip finally named the SOC as RV1108, so change it
> for compatible.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/rockchip.txt   | 4 ++--
>  arch/arm/boot/dts/Makefile                           | 2 +-
>  arch/arm/boot/dts/{rk1108-evb.dts => rv1108-evb.dts} | 7 ++++---
>  3 files changed, 7 insertions(+), 6 deletions(-)
>  rename arch/arm/boot/dts/{rk1108-evb.dts => rv1108-evb.dts} (89%)

Would be nice to have the information in the discussion summarized here.

Acked-by: Rob Herring <robh@kernel.org>
