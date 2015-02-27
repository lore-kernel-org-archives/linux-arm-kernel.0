From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Feb 2015 13:53:56 +0100
Subject: [PATCH 07/10] ARM: integrator: use explicit core module options
In-Reply-To: <1424967096-261582-1-git-send-email-arnd@arndb.de>
References: <1424967096-261582-1-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdYNCZrkmRnnBwFJVt6w=QoBNy64jiO4+OQzZkJ=O4-RYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 5:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> For consistency with the other platforms, this remove the CPU
> selection logic in mm/Kconfig that was only used by integrator,
> and adds specific options for each available core tile and core
> module, which in turn select the correct CPUs.
>
> This is consistent with the new way that we do it for realview
> and all other platforms.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, compiled, and booted on Integrator/AP with an ARM926 core
tile.

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
