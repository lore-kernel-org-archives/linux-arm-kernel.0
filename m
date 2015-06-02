From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Jun 2015 23:18:34 +0200
Subject: [PATCH 0/3] ARM: dts: sun8i-a33: Support for Sinlinx SinA33 dev
 board
In-Reply-To: <1433239443-738-1-git-send-email-wens@csie.org>
References: <1433239443-738-1-git-send-email-wens@csie.org>
Message-ID: <20150602211834.GD23777@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 06:04:00PM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> This series enables support for the Sinlinx SinA33 dev board. This
> is a core/daughter board SDK kit from Chinese vendor Sinlinx. The
> core board itself does not have any special connectivity, so I
> didn't split them into 2 files.
> 
> The series is based on Vishnu/Hans' A33 series (v2). As the last
> (dts) patch was not merged yet, there might be a conflict in
> dts/Makefile.
> 
> Patch 1 adds a pinmux setting for uart0 on PB pins. This is new on
> A33, and is much better than using R_UART for console on A23, as
> we can also see messages from BROM/boot0 when developing, and also
> use the same earlyprintk settings as other sunxi platforms.
> 
> Patch 2 adds a pinmux setting for 8 bit eMMC on mmc2.
> mmc2 also has a reset pin, though I'm not sure if our mmc driver
> actually uses it. Not using it seems to work anyway.
> 
> Patch 3 adds the dts file for the SinA33 dev board. Just the basic
> set of features are enabled: UART console, MMC, LRADC.

Applied all three, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150602/5aa5a4fc/attachment.sig>
