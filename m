From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Dec 2010 14:02:57 +0000
Subject: [PATCH] mmci: drop superfluous regulator #ifdef
In-Reply-To: <1291297018-3074-1-git-send-email-linus.walleij@stericsson.com>
References: <1291297018-3074-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101202140257.GD3182@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 02:36:58PM +0100, Linus Walleij wrote:
> The regulator and MMC frameworks provide the proper stub functions
> for the regulator functions anyway, get rid of this.

It's more that the regulator API stubs have been changed to match what
MMC is doing (there always were stubs) but that doesn't make any
material difference.

> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
