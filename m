From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Nov 2012 11:47:14 +0000
Subject: [PATCH] mmc: Standardise capability type
In-Reply-To: <CACRpkdZ+V1aiQ-c62v9jdv93wMGu9hrSnXj_a9jx3uOTbot44A@mail.gmail.com>
References: <1352896551-17948-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ+V1aiQ-c62v9jdv93wMGu9hrSnXj_a9jx3uOTbot44A@mail.gmail.com>
Message-ID: <201211151147.14858.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 November 2012, Linus Walleij wrote:
> 
> On Wed, Nov 14, 2012 at 1:35 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > There are discrepancies with regards to how MMC capabilities
> > are carried throughout the subsystem. Let's standardise them
> > to elevate any confusion.
> >
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: linux-mmc at vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Looks good to me, and these are obviously
> u32 bitfields by design, so:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
