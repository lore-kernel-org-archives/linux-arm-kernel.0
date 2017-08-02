From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Aug 2017 14:29:52 +0200
Subject: [PATCH 02/12] ARM: ep93xx: use ARM_PATCH_PHYS_VIRT
In-Reply-To: <20170720154939.3250697-1-arnd@arndb.de>
References: <20170720154616.3250481-1-arnd@arndb.de>
 <20170720154939.3250697-1-arnd@arndb.de>
Message-ID: <CACRpkdYRYysAum99m55HKm-9SEH6Up=a7PnvQxkYAKfACPQ=Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 5:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Just like ARCH_MULTIPLATFORM, we want to use ARM_PATCH_PHYS_VIRT
> when possible, but that fails for NOMMU or XIP_KERNEL configurations.
> Using 'imply' instead of 'select' gets this right and only uses
> the symbol when we don't have to hardcode the address anyway.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I assume you will apply this directly to ARM SoC.

Yours,
Linus Walleij
