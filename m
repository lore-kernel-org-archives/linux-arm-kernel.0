From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Apr 2017 16:52:29 +0200
Subject: [PATCH] arm64: dts: allwinner: pine64: Prepare optional UART
 nodes with pinctrl
In-Reply-To: <20170418192538.24174-1-afaerber@suse.de>
References: <20170418053458.phcbp4da3vatejpg@lukather>
 <20170418192538.24174-1-afaerber@suse.de>
Message-ID: <20170419145229.esqvco3clilqk776@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 09:25:38PM +0200, Andreas F?rber wrote:
> Pine64 exposes all A64 UARTs, not just UART0.
> 
> Since the pins can be used as GPIO, don't enable the new UART nodes by
> default, but prepare the pinctrl settings to aid in activating them via
> overlays, i.e., overriding the status property of &uartX nodes.
> 
> For UART4 (Euler) the safer route of not including RTS/CTS pins is chosen,
> whereas for UART1 (Bluetooth) they are included.
> 
> Add the corresponding pinctrl nodes where missing.
> 
> Suggested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170419/9463c8d7/attachment.sig>
