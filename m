From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Nov 2016 12:57:38 -0600
Subject: [PATCH 6/6] ARM: dts: rockchip: add rockchip RK1108 Evaluation
 board
In-Reply-To: <1478177039-12257-1-git-send-email-andy.yan@rock-chips.com>
References: <1478175975-11779-1-git-send-email-andy.yan@rock-chips.com>
 <1478177039-12257-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <20161110185738.dyglqkhokc46zd3v@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 08:43:59PM +0800, Andy Yan wrote:
> RK1108EVB is designed by Rockchip for CVR field.
> This patch add basic support for it, which can boot with
> initramfs into shell.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/rockchip.txt |  3 +
>  arch/arm/boot/dts/Makefile                         |  1 +
>  arch/arm/boot/dts/rk1108-evb.dts                   | 69 ++++++++++++++++++++++
>  3 files changed, 73 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk1108-evb.dts

Acked-by: Rob Herring <robh@kernel.org>
