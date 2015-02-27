From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Feb 2015 13:20:12 +0100
Subject: [PATCH 01/10] ARM: realview: remove sparsemem hack
In-Reply-To: <1424966890-260805-2-git-send-email-arnd@arndb.de>
References: <1424966890-260805-1-git-send-email-arnd@arndb.de>
 <1424966890-260805-2-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdaamy0uJm=rpvB4Hf7YXdxhaC8wcA_VEAekFNU2cGsFSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 5:08 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The realview-pbx platform has an elaborate way of avoiding the use of highmem
> by redefining its phys_to_virt function. In practice this doesn't help all
> that much, and it gets in the way of doing multiplatform builds for
> realview.
>
> This removes the feature and kills off the mach/memory.h file for realview.
> We also lose the ability to do sparsemem with this patch, but that should
> be put back into place for generic multiplatform configurations, to save
> a little memory on PBX.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
