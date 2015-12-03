From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 3 Dec 2015 10:44:48 +0100
Subject: [PATCH 2/4] irqchip/sunxi-nmi: Add sun9i-a80 variant to binding
 doc
In-Reply-To: <1449130813-22400-3-git-send-email-wens@csie.org>
References: <1449130813-22400-1-git-send-email-wens@csie.org>
 <1449130813-22400-3-git-send-email-wens@csie.org>
Message-ID: <20151203094448.GV29263@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 04:20:11PM +0800, Chen-Yu Tsai wrote:
> sun9i A80 introduces a new variant of the NMI controller. The registers
> are reordered, but the functionality remains the same.
> 
> Add a new compatible string for it.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151203/be99ff6f/attachment.sig>
