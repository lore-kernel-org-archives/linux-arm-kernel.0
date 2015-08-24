From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Aug 2015 08:22:55 +0200
Subject: [PATCH 14/18] ARM: sunxi: use const and __initconst for
 smp_operations
In-Reply-To: <1440390978-22796-15-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
 <1440390978-22796-15-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20150824062255.GA2413@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 01:36:14PM +0900, Masahiro Yamada wrote:
> The smp_operations structure is not over-written, so add const
> qualifier and replace __initdata with __initconst.
> 
> Also, add static to sun8i_smp_ops.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150824/9e349cd7/attachment.sig>
