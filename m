From: olof@lixom.net (Olof Johansson)
Date: Mon, 1 Feb 2016 12:19:22 -0800
Subject: [PATCH] ARM: realview: use "depends on" instead of "if" after
 prompt
In-Reply-To: <1453722164-23198-1-git-send-email-yamada.masahiro@socionext.com>
References: <1453722164-23198-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160201201922.GE13508@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 08:42:44PM +0900, Masahiro Yamada wrote:
> This platform recently moved to multi-platform, so missed the global
> fixup by commit e32465429490 ("ARM: use "depends on" for SoC configs
> instead of "if" after prompt").  Fix it now.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to fixes.


-Olof
