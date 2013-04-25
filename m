From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:44:12 +0200
Subject: [PATCH 31/32] ARM: ux500: Stop passing MMC's platform data for
 Device Tree boots
In-Reply-To: <1366279934-30761-32-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-32-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaF3he9X7fd88TrmtNK8g1U4jUEuy6QpKG0Hg8srXWbng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:12 PM, Lee Jones <lee.jones@linaro.org> wrote:

> It was required to pass DMA channel configuration information to the
> MMC driver before the new DMA API was in place. Now that it is, and
> is fully compatible with Device Tree we can stop doing that.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Really nice provided the dependencies are in place.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
