From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 May 2013 12:37:12 +0200
Subject: [PATCH 12/39] ARM: u300: set up board power from device tree
In-Reply-To: <1369991954-17406-13-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
 <1369991954-17406-13-git-send-email-linus.walleij@stericsson.com>
Message-ID: <6621177.ZgrPQ48FXE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 May 2013 11:18:47 Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This adds support for setting up the board power from the
> device tree on the U300. We use a board-specific node in the
> device tree for the S365 board and bind a regulator for the
> board power to this node.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This is fairly unusual, I think I've never seen a platform driver
registered for a board.  Is that the intended method for hogging
a regulator?

	Arnd
