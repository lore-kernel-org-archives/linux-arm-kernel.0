From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Jul 2017 11:06:51 +0200
Subject: [PATCH 01/11] ARM: dts: sun8i: a83t: Switch to CCU device tree
 binding macros
In-Reply-To: <20170714064302.20383-2-wens@csie.org>
References: <20170714064302.20383-1-wens@csie.org>
 <20170714064302.20383-2-wens@csie.org>
Message-ID: <20170717090651.olohxjjzte4whvvz@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 02:42:52PM +0800, Chen-Yu Tsai wrote:
> Now that the CCU device tree binding headers have been merged, we can
> use the properly named macros in the device tree, instead of raw
> numbers.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> This patch is included as it is a pre-requisite to the other device
> tree changes in this series. It is however independent, and should
> be applied as a fix for 4.13-rc, not for -next, and preferably sooner
> than later.

Applied as a fix for 4.13, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/273422a1/attachment.sig>
