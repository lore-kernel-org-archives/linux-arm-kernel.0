From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Mar 2013 03:35:45 +0100
Subject: [PATCH 02/14] MAINTAINERS: remove arch/arm/plat-nomadik/
In-Reply-To: <1362275632-20242-3-git-send-email-cesarb@cesarb.net>
References: <1362275632-20242-1-git-send-email-cesarb@cesarb.net>
 <1362275632-20242-3-git-send-email-cesarb@cesarb.net>
Message-ID: <CACRpkdZ4he9BFCJ3ta59ZUsNZ=F88o8iR_y5B5Rk=EgrfZVZsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 3, 2013 at 2:53 AM, Cesar Eduardo Barros <cesarb@cesarb.net> wrote:

> The files within that directory were moved to other places over the
> course of several commits. I only added the ones moved in the patch
> series which finally removed the directory; untangling the rest will
> take more work, since some seem to be shared with ux500.
>
> In fact, the ARM/Ux500 ARM ARCHITECTURE block has patterns for files
> named "nomadik" too. The patterns in this pair of MAINTAINER blocks
> really need a review from the respective maintainters.
>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>

Thanks for doing this Cesar!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

The reason some drivers are named "Nomadik" is that that
platform was the first using that IP block, but in some cases
like drivers/i2c/busses/i2c-nomadik.c the original platform has
not yet been migrated to it.

Yours,
Linus Walleij
