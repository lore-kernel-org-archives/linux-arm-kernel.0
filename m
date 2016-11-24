From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Nov 2016 21:04:07 +0100
Subject: [PATCH] ARM: dts: sun6i: hummingbird: Enable USB OTG
In-Reply-To: <20161124112908.4796-1-wens@csie.org>
References: <20161124112908.4796-1-wens@csie.org>
Message-ID: <20161124200407.soib3se5lp5vvkdo@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 07:29:08PM +0800, Chen-Yu Tsai wrote:
> The A31 Hummingbird has a mini USB OTG port, and uses GPIO pins from the
> SoC for ID pin and VBUS detection and VBUS control. The PMIC can also do
> VBUS detection and control.
> 
> Here we prefer to use the PMIC's DRIVEVBUS function to control VBUS for
> USB OTG, as that is the hardware default.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161124/fb996ac4/attachment.sig>
