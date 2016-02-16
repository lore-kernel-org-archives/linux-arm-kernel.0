From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Feb 2016 16:43:22 +0100
Subject: [PATCH 2/4] gpio: ks8695: remove irq_to_gpio function
In-Reply-To: <1455551208-2825510-3-git-send-email-arnd@arndb.de>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <1455551208-2825510-1-git-send-email-arnd@arndb.de>
 <1455551208-2825510-3-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdZ0uFKKieDjEvdhsT+QVUBq2YYa64nqbh5rhFnChD9jGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 4:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The ks8695 gpio driver has its own copy of the irq_to_gpio()
> function. This is completely unused in the mainline kernel
> after we converted all remaining users several years ago,
> so we can remove the definition as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
