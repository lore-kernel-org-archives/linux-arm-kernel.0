From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 20 Sep 2016 09:30:49 +0200
Subject: [PATCH] ARM: uniphier: select ARCH_HAS_RESET_CONTROLLER
In-Reply-To: <1474346599-29925-1-git-send-email-yamada.masahiro@socionext.com>
References: <1474346599-29925-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1474356649.4030.8.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 20.09.2016, 13:43 +0900 schrieb Masahiro Yamada:
> The UniPhier reset driver (drivers/reset/reset-uniphier.c) has been
> merged.  Select ARCH_HAS_RESET_CONTROLLER from the SoC Kconfig.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
