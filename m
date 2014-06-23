From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Jun 2014 20:56:31 +0200
Subject: [PATCH v3 4/4] ARM: sun8i: dt: Add Ippo-q8h v5 support
In-Reply-To: <1403275973-24259-5-git-send-email-wens@csie.org>
References: <1403275973-24259-1-git-send-email-wens@csie.org>
 <1403275973-24259-5-git-send-email-wens@csie.org>
Message-ID: <20140623185631.GK19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 10:52:53PM +0800, Chen-Yu Tsai wrote:
> The Ippo-q8h is a tablet circuit board commonly found in cheap Android
> tablets with A23 SoCs. There are at least 2 versions of the board, with
> different peripherals, such as WiFi chips.
> 
> Common features among these tablets include 512 MB DRAM, NAND, MMC, LCD,
> capacitive touchscreen, accelerometer, 1 or 2 camera sensors, USB OTG,
> microphone and speaker.
> 
> v5 of these board designs has a ESP8089 WiFi chip (not supported)
> connected to mmc1. This patch adds very basic support.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Fixed the whitespace warning and applied.

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140623/b20dc6b4/attachment.sig>
