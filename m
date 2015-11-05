From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 05 Nov 2015 10:34:43 +0100
Subject: [PATCH] reset: check return value of reset_controller_register()
In-Reply-To: <1446702896-1156-1-git-send-email-yamada.masahiro@socionext.com>
References: <1446702896-1156-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1446716083.3894.8.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 05.11.2015, 14:54 +0900 schrieb Masahiro Yamada:
> Currently, reset_controller_register() always return 0, but it would
> be better to check its return code.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied with S?ren's Acked-by, thanks.

regards
Philipp
