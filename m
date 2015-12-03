From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 3 Dec 2015 10:44:25 +0100
Subject: [PATCH 1/4] irqchip/sunxi-nmi: Rename binding doc filename to
 allwinner,sunxi-nmi.txt
In-Reply-To: <1449130813-22400-2-git-send-email-wens@csie.org>
References: <1449130813-22400-1-git-send-email-wens@csie.org>
 <1449130813-22400-2-git-send-email-wens@csie.org>
Message-ID: <20151203094425.GU29263@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 04:20:10PM +0800, Chen-Yu Tsai wrote:
> The NMI controller is found in all Allwinner multi-core SoCs. It is not
> limited to sun[67]i, nor is it always found in the "system controller"
> block. On sun[68]i, it is in the RTC block, while on sun9i, it is in the
> PRCM block.
> 
> Drop these 2 specific bits from the binding doc filename.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151203/1f4b5f51/attachment.sig>
