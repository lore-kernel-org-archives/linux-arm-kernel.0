From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Mar 2015 18:37:18 +0100
Subject: [PATCH v5 2/2] ARM: dts: sun9i: optimus: Switch to phy core
 regulator bindings for usb phys
In-Reply-To: <1426305437-15208-3-git-send-email-wens@csie.org>
References: <1426305437-15208-1-git-send-email-wens@csie.org>
 <1426305437-15208-3-git-send-email-wens@csie.org>
Message-ID: <20150318173718.GT4638@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 14, 2015 at 11:57:17AM +0800, Chen-Yu Tsai wrote:
> Since the phy core already supports specifying a regulator to handle
> during power up/down, it was decided to drop the regulator support
> in the sun9i usb phy driver.
> 
> This patch switches the DT to the core bindings. This and the phy driver
> would be in the same release and should not be a problem as far as DT
> stability goes.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied with Kishon's Acked By

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/760277b9/attachment.sig>
