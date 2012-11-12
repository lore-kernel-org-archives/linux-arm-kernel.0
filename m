From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 14:45:17 +0000
Subject: [PATCH 0/6] ARM: integrator: SoC bus & cleanup
In-Reply-To: <1352681542-12835-1-git-send-email-linus.walleij@linaro.org>
References: <1352681542-12835-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201211121445.17924.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 November 2012, Linus Walleij wrote:
> This series will:
> 
> - Switch the Integrator/AP and /CP to use the SoC bus
>   when booting from device tree.
> - Group all devices on the SoC below this bus so as to
>   set a good example of how to do this. The bus was
>   invented by Lee Jones, let's show how it's to be used
>   on a DT:ed SoC.
> - Fetch the special system controller offsets from two
>   special device tree nodes for each case and replace
>   the static mappings with these at boot.
> - Move some static remaps to the ATAG-only code path
>   and delete some static maps that aren't used.

Nice series,

Acked-by: Arnd Bergmann <arnd@arndb.de>
