From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Jun 2016 22:44:26 +0200
Subject: [PATCH 3/3] ARM: dts: sun8i-h3: Add dts file for Sinovoip BPI-M2+
In-Reply-To: <1464853811-15233-4-git-send-email-wens@csie.org>
References: <1464853811-15233-1-git-send-email-wens@csie.org>
 <1464853811-15233-4-git-send-email-wens@csie.org>
Message-ID: <20160607204426.GB14179@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 03:50:11PM +0800, Chen-Yu Tsai wrote:
> The BPI-M2+ is an H3 development board. It is a smaller form factor than
> the original BPI-M2, with the new H3 SoC.
> 
> It has 1GB DRAM, 8GB eMMC, a micro SD card slot, HDMI output, 2 USB
> host connector and 1 USB OTG connector, an IR receiver, WiFi+BT based
> on Ampak AP6212.
> 
> The board also has a 3 pin header for (debug) UART, a 40 pin GPIO header
> based on the Raspberry Pi B+, but the peripheral signals are not the
> same, and an FPC connector for connecting BPI's camera.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

I fixed the whitespace error, and applied all three.

Thanks!
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/20e19201/attachment.sig>
