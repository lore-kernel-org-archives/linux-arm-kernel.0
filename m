From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Nov 2010 16:46:12 +0100
Subject: [PATCH 03/10] MCDE: Add pixel processing registers
In-Reply-To: <1289390653-6111-4-git-send-email-jimmy.rubin@stericsson.com>
References: <1289390653-6111-1-git-send-email-jimmy.rubin@stericsson.com>
	<1289390653-6111-3-git-send-email-jimmy.rubin@stericsson.com>
	<1289390653-6111-4-git-send-email-jimmy.rubin@stericsson.com>
Message-ID: <201011121646.12927.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 November 2010, Jimmy Rubin wrote:
> This patch adds support for MCDE, Memory-to-display controller
> found in the ST-Ericsson ux500 products.
> 
> This patch adds pixel processing registers found in MCDE.
> 
> Signed-off-by: Jimmy Rubin <jimmy.rubin@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij.stericsson.com>

The same comments I gave for the configuration registers
apply to this one and the other headers as well.

	Arnd
