From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Aug 2015 11:57:11 +0200
Subject: [PATCH] ARM: Feroceon: use of_iomap() to map register base
In-Reply-To: <1439035899-1783-1-git-send-email-yamada.masahiro@socionext.com>
References: <1439035899-1783-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20150813095711.GJ30160@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 08, 2015 at 09:11:39PM +0900, Masahiro Yamada wrote:
> The sequence of of_address_to_resource() and ioremap() can be
> replaced with of_iomap().
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Olof Johansson <olof@lixom.net>

Please submit this to Russell's patch tracker, he's usually the one who merges
patches to arch/arm/mm/*.


-Olof
