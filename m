From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 3 Dec 2015 10:45:15 +0100
Subject: [PATCH 3/4] irqchip/sunxi-nmi: Support sun9i A80 NMI controller
In-Reply-To: <1449130813-22400-4-git-send-email-wens@csie.org>
References: <1449130813-22400-1-git-send-email-wens@csie.org>
 <1449130813-22400-4-git-send-email-wens@csie.org>
Message-ID: <20151203094515.GW29263@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 04:20:12PM +0800, Chen-Yu Tsai wrote:
> The A80 moves the NMI controller into the PRCM address space, and also
> rearranges the registers.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151203/69d0357b/attachment.sig>
