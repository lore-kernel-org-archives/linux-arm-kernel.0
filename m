From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Apr 2012 11:18:55 +0200
Subject: [PATCH 6/7] MMC: mmci: Enable Device Tree support for ux500
 variants
In-Reply-To: <4F8BE131.4090701@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
 <4F8BE131.4090701@linaro.org>
Message-ID: <CACRpkdZ=ZSa2ZXA91Fited5-BnueV8CSKUrnBhdkWFrdEe2Grw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 11:06 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On 16/04/12 09:48, Linus Walleij wrote:

>> Can you split this in a clean patch to mmci.c and another patch for all
>> the ux500 stuff? You can add my Acked-by for both.
>
> I can do that. You'll have it by this afternoon.

Then it looks like only runtime dependencies exist between the MMCI
and ux500 patch and they can be merged to different trees right?

I'll be happy to do that if I know that Russell picks the mmci.c portions.

Yours,
Linus Walleij
