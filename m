From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Jun 2013 14:18:44 +0200
Subject: [PATCH 2/3] ARM: integrator: let pciv3 use mem/premem from device
 tree
In-Reply-To: <1372201551-25984-1-git-send-email-linus.walleij@linaro.org>
References: <1372201551-25984-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201306271418.45155.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 June 2013, Linus Walleij wrote:
> Instead of relying on the hard-coded mem/premem bases for
> the PCI side, read in these from the device tree in the
> DT probe path. Hard-code the old values on the non-DT probe
> path. Introduce some static locals to hold these addresses
> instead of the earlier static #defines.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks!

	Arnd
