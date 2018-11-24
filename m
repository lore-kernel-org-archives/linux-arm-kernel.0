From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 24 Nov 2018 21:44:11 +0100
Subject: [PATCH 3/9] drm: replace "drm_dev_unref" function with
 "drm_dev_put"
In-Reply-To: <1542387884.1134874.1579436592.07F916C5@webmail.messagingengine.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <20181115221634.22715-4-greenfoo@gluegarage.com>
 <1542363310.23489.22.camel@pengutronix.de>
 <1542387884.1134874.1579436592.07F916C5@webmail.messagingengine.com>
Message-ID: <CACRpkda1FJOzBn42=7GgExA3fdNJabc_=JUba4y7k34uy9tsKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 6:04 PM Fernando <greenfoo@gluegarage.com> wrote:

> I'm new on this, how should I proceed? Should I create a new (V2) patch series with
> these changes reverted? Or will the maintainer automatically take care
> of this when merging?

I fixed it :) I think. At least I hope I didn't do something bad.

Yours,
Linus Walleij
