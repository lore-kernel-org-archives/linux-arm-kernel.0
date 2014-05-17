From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 17 May 2014 18:41:14 +0200
Subject: [PATCH] ARM: sunxi: dt: build DTs according to new MACH_SUNxI
 Kconfig symbols
In-Reply-To: <1400332280-5398-1-git-send-email-wens@csie.org>
References: <1400332280-5398-1-git-send-email-wens@csie.org>
Message-ID: <20140517164114.GL29258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 17, 2014 at 09:11:20PM +0800, Chen-Yu Tsai wrote:
> Allwinner sunxi support has been split into the various SoCs in Kconfig.
> Adapt the new symbols for the device trees.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> Hi,
> 
> This patch lets us build the DTBs according to the SoCs we selected in
> kernel config. This matches the build behavior of the kernel itself
> after splitting up sunxi support to various SoCs in Kconfig.
> 
> Maxime, could you take this?

Applied, thanks.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140517/fdcc119e/attachment-0001.sig>
