From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 9 Mar 2015 11:13:54 +0100
Subject: [PATCH v2 1/2] ARM: dts: sun7i: Add dts file for Wexler TAB7200
In-Reply-To: <1425815853-5759-1-git-send-email-mamlinav@gmail.com>
References: <1425456947-4152-1-git-send-email-mamlinav@gmail.com>
 <1425815853-5759-1-git-send-email-mamlinav@gmail.com>
Message-ID: <20150309101354.GP5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 08, 2015 at 02:57:33PM +0300, Aleksei Mamlin wrote:
> This patch add support for Wexler TAB7200 tablet.
> 
> The Wexler TAB7200 is a A20 based tablet with 7 inch display(800x480),
> capacitive touchscreen(5 fingers), 1G RAM, 4G NAND, micro SD card slot,
> mini HDMI port, 3.5mm audio plug, 1 USB OTG port and 1 USB 2.0 port.
> 
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> ---
> Changes since v1:
> * Split to two patches:
>   The first one adds dts file for Wexler TAB7200.
>   The second one adds vendor-prefix for Wexler.
> * Remove include dt-bindings/pinctrl/sun4i-a10.h because we don't use
>   the pinctrl header.

Applied the two patches, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150309/e0f8093d/attachment.sig>
