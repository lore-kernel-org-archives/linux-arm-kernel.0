From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jul 2015 19:01:06 +0200
Subject: [PATCH v2 1/2] ARM: sunxi_defconfig: Enable DMA_SUN6I, P2WI,
 PWM, cryptodev, EXTCON, FHANDLE
In-Reply-To: <1438354602-6361-2-git-send-email-wens@csie.org>
References: <1438354602-6361-1-git-send-email-wens@csie.org>
 <1438354602-6361-2-git-send-email-wens@csie.org>
Message-ID: <20150731170106.GM2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 10:56:41PM +0800, Chen-Yu Tsai wrote:
> Enable sun6i DMA engine, sun6i P2WI, PWM, and crypto engine (Security
> System) drivers by default. EXTCON is needed by the updated sun4i USB
> PHY driver.
> 
> While at it, enable FHANDLE, which is needed by systemd and newer
> versions of udev. Also enable CGROUPS for systemd.
> 
> And get rid of POWER_RESET, as the sun6i power reset driver has been
> removed in favor of proper sun6i watchdog support.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/5ca5a25f/attachment.sig>
