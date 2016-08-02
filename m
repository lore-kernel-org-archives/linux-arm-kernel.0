From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Aug 2016 09:47:50 +0200
Subject: [PATCH] ARM: do away with final ARCH_REQUIRE_GPIOLIB
In-Reply-To: <1470123873-8073-1-git-send-email-linus.walleij@linaro.org>
References: <1470123873-8073-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <4971362.dFskjWhYAq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 2, 2016 9:44:33 AM CEST Linus Walleij wrote:
> A new user of the Kconfig selection of ARCH_REQUIRE_GPIOLIB
> has appeared. Replace with just selecting GPIOLIB.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: I plan to send this directly in this merge
> window to get rid of the old Kconfig symbols, please ACK
> it.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Note that sending this one along with your patches requires
you to base on top of our branches (which are now merged).

Alternatively we could queue this up as a bugfix: there is no
harm in selecting a symbol that has been removed, so we don't
have a strict dependency that requries it this one to go
in before the removal.

	Arnd
