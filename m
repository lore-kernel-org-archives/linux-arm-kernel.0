From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 Jun 2016 14:39:10 +0200
Subject: [PATCH] ARM: sunxi/dt: make the CHIP inherit from
 allwinner,sun5i-a13
In-Reply-To: <1465904284-329-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465904284-329-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160614123910.GI9354@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 14, 2016 at 01:38:04PM +0200, Boris Brezillon wrote:
> The sun4i-timer driver registers its sched_clock only if the machine is
> compatible with "allwinner,sun5i-a13", "allwinner,sun5i-a10s" or
> "allwinner,sun4i-a10".
> Add the missing "allwinner,sun5i-a13" string to the machine compatible.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Could you add a Fixes tag, and Cc stable?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160614/922ce54e/attachment.sig>
