From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 19 Jan 2011 11:44:20 +0000
Subject: [PATCH] ux500: add a few AB8500 regulator consumers v2
In-Reply-To: <1295390574-8969-1-git-send-email-linus.walleij@stericsson.com>
References: <1295390574-8969-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110119114419.GD15965@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 11:42:54PM +0100, Linus Walleij wrote:
> Try to make the regulators a little bit more useful by adding some
> of the most basic consumers we're going to have in the end.

This looks idiomatic for the regulator API, though I've not checked any
of the chips to make sure that things are joined up there.
