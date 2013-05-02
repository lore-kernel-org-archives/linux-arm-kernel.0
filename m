From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 May 2013 17:26:49 +0200
Subject: [PATCH 20/23 v2] ARM: u300: add SPI PL022 to the device tree
In-Reply-To: <1367485952-6212-1-git-send-email-linus.walleij@stericsson.com>
References: <1367485952-6212-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201305021726.49729.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This registers the PL022 PrimeCell from the U300 device
> tree. We make a new copy of the platform data for the
> device tree boot path, as the old platform data is in an
> older file which will be going away.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Why do you need both the platform data and the DT description?

	Arnd
