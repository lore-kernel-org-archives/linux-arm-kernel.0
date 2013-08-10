From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 10 Aug 2013 19:19:23 +0200
Subject: [PATCH 0/6] ARM: sunxi: DTSI cleanups
In-Reply-To: <1375608844-13159-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375608844-13159-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130810171923.GI2911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 04, 2013 at 11:33:58AM +0200, Maxime Ripard wrote:
> Hi everyone,
> 
> This small patchset removes the useless reg property in the soc bus that is not
> required for the simple-bus we're using.
> 
> It also fixes the base address of this bus in the node name that was wrong from
> the start.
> 
> Maxime
> 
> Maxime Ripard (6):
>   ARM: sun4i: a10: Remove useless simple-bus reg property
>   ARM: sun4i: dt: Fix A10 SoC bus base address
>   ARM: sun5i: a10s: Remove useless simple-bus reg property
>   ARM: sun5i: dt: Fix A10s SoC bus base address
>   ARM: sun5i: a13: Remove useless simple-bus reg property
>   ARM: sun5i: dt: Fix A13 SoC bus base address
> 
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts       | 2 +-
>  arch/arm/boot/dts/sun4i-a10-hackberry.dts        | 2 +-
>  arch/arm/boot/dts/sun4i-a10-mini-xplus.dts       | 2 +-
>  arch/arm/boot/dts/sun4i-a10.dtsi                 | 3 +--
>  arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 2 +-
>  arch/arm/boot/dts/sun5i-a10s.dtsi                | 3 +--
>  arch/arm/boot/dts/sun5i-a13-olinuxino.dts        | 2 +-
>  arch/arm/boot/dts/sun5i-a13.dtsi                 | 3 +--
>  8 files changed, 8 insertions(+), 11 deletions(-)

Applied to my sunxi/dt-for-3.12 branch.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130810/3f7152c9/attachment.sig>
