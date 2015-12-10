From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Dec 2015 13:50:26 +0100
Subject: [PATCH 1/4] ARM: realview: refresh defconfig
In-Reply-To: <1449751184-13424-1-git-send-email-linus.walleij@linaro.org>
References: <1449751184-13424-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <3048218.mqPMhMel7t@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 December 2015 13:39:44 Linus Walleij wrote:
> This updates the RealView defconfig with the latest Kconfig
> structure.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 

All four patches look good to me, and I've checked that none
of the options that are no longer enabled in the defconfig
need to be brought back.

Acked-by: Arnd Bergmann <arnd@arndb.de>
