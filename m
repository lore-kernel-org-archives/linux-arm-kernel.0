From: olof@lixom.net (Olof Johansson)
Date: Mon, 1 Feb 2016 12:17:57 -0800
Subject: [PATCH] ARM: realview: use const and __initconst for
 smp_operations
In-Reply-To: <1453721587-15363-1-git-send-email-yamada.masahiro@socionext.com>
References: <1453721587-15363-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160201201757.GB13508@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 08:33:07PM +0900, Masahiro Yamada wrote:
> This newly added code missed the global fixup by commit 75305275a721
> ("ARM: use const and __initconst for smp_operations").  So fix it now.
> 
> Also, add missing "static" qualifier.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Applied to fixes.


-Olof
