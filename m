From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 Nov 2015 18:02:17 -0800
Subject: [PATCH v3 0/3] ARM: dts: sun4i: gemei-g9: Devicetree improvements
In-Reply-To: <1446832486-32319-1-git-send-email-plaes@plaes.org>
References: <1446832486-32319-1-git-send-email-plaes@plaes.org>
Message-ID: <20151109020217.GZ6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 07:54:43PM +0200, Priit Laes wrote:
> Improvements to devicetree setup:
>  - Converted to use axp209 regulator nodes
>  - Fix invalid regulator for LRADC keys
>  - Enable audio codec node
> 
> Changes sinve v2:
>  - Dropped applied "Added IRQ configuration for bma250 accelerometer" patch
> 
> Changes since v1:
>  - Dropped NAND patch because driver is not yet ready
>  - Dropped applied KEYBOARD_SUN4I_LRADC patch
>  - Added sun4i audio codec patch
> 
> 
> Priit Laes (3):
>   ARM: dts: sun4i: gemei-g9: Convert to use axp209 regulator nodes
>   ARM: dts: sun4i: gemei-g9: Use reg_ldo2 instead of reg_vcc3v0
>   ARM: dts: sun4i: gemei-g9: Enable sun4i audio codec support
> 
>  arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 42 +++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 6 deletions(-)

Applied, thanks !

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151108/71789b29/attachment.sig>
