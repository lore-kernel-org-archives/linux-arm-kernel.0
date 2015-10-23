From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 22:11:03 +0200
Subject: [PATCH 1/4] ARM: dts: uniphier: use stdout-path instead of console
In-Reply-To: <1445427390-22750-2-git-send-email-yamada.masahiro@socionext.com>
References: <1445427390-22750-1-git-send-email-yamada.masahiro@socionext.com>
 <1445427390-22750-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <4559032.j1oBm0CRbv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 October 2015 20:36:27 Masahiro Yamada wrote:
> Specifying both console and stdout-path is redundant.  Add options
> ":115200n8" to stdout-path and drop "console=ttyS0,115200".
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 

Applied, thanks!

	Arnd
