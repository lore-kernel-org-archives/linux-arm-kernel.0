From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 9 Feb 2016 09:14:20 +0100
Subject: [PATCH 6/6] ARM: multi_v7_defconfig: Enable MUSB HDRC driver
 with Allwinner glue
In-Reply-To: <1454774029-10469-7-git-send-email-wens@csie.org>
References: <1454774029-10469-1-git-send-email-wens@csie.org>
 <1454774029-10469-7-git-send-email-wens@csie.org>
Message-ID: <20160209081420.GN31506@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 06, 2016 at 11:53:49PM +0800, Chen-Yu Tsai wrote:
> Allwinner SoCs typically have a Mentor Graphics Inventra MUSB high speed
> dual role controller for USB OTG.
> 
> Now that the issue with MUSB and USB gadget registration order has been
> resolved, we can enable this driver in dual role mode.
> 
> This patch only enables the driver core and Allwinner platform support.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/c34a9ec8/attachment.sig>
