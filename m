From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 15 Sep 2013 20:15:12 +0200
Subject: [PATCH 0/6] deletion of the Shark machine
In-Reply-To: <1379069467-3974-1-git-send-email-linus.walleij@linaro.org>
References: <1379069467-3974-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201309152015.12676.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 September 2013, Linus Walleij wrote:
> The RFC series were not met by any protests from active users
> so this is an iteration of the series as sharp material for
> v3.13. After collecting ACKs a pull request will be made to
> the ARM SoC tree.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Note that although you just ask for Acks from the other subsystem maintainers
here, I think it would be just as well to apply some or all of the patches
in subsystem trees. Since the code is just going away, there is no requirement
to do it atomically.

	Arnd
