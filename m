From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 23:12:04 +0200
Subject: [PATCH 29/63] ARM: ux500: Stop passing MMC's platform data for
 Device Tree boots
In-Reply-To: <1367591569-32197-30-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-30-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdY8N1_xH8RAnqA-9W9cUyX5QVs4WYJERc31TK2r6Yz8qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

> It was required to pass DMA channel configuration information to the
> MMC driver before the new DMA API was in place. Now that it is, and
> is fully compatible with Device Tree we can stop doing that.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Can't apply this because of dependencies to be merged
by Russell.

Yours,
Linus Walleij
