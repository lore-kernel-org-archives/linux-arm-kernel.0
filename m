From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2012 11:49:57 +0100
Subject: [GIT PULL] Ux500 pin changes
In-Reply-To: <201211122235.00973.arnd@arndb.de>
References: <CACRpkdYjEmQRU530N3sP7t_RfM_NLhEcMf6YCBdf4LC7M7fQDQ@mail.gmail.com>
 <201211122235.00973.arnd@arndb.de>
Message-ID: <CACRpkdZ0_3ow9VwGGvFtj_pbYNG+cctB6kUK1FBe4sjU=MTgww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 11:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> u8500_defconfig now gives me two new errors in arm-soc/for-next when building with
> -Werror:
>
> arch/arm/mach-ux500/board-mop500-pins.c:73:22: error: 'out_hi_wkup_pdis' defined but not used [-Werror=unused-variable]

I've sent a fix for this, could you apply that patch directly to the
drivers branch?

> and the existing:
>
> ERROR (phandle_references): Reference to non-existent node or label "tc3589x_gpio"
>
> Can you provide patches to fix these up?

What on earth is that? Lee, do you know how to fix this one up, I shamelessly
assume it to be related to commit:
commit 3113e679021a3a6bace1c62a8432cc0ec27c09ab
"gpio: Enable the tc3298x GPIO expander driver for Device Tree"

Yours,
Linus Walleij
