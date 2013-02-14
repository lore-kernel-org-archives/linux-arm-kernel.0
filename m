From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Feb 2013 16:34:28 +0100
Subject: [PATCH v2 02/10] gpio: pxa: avoid to use global irq base
In-Reply-To: <511CDC78.2000400@compulab.co.il>
References: <1359886551-20950-1-git-send-email-haojian.zhuang@linaro.org>
 <1359886551-20950-3-git-send-email-haojian.zhuang@linaro.org>
 <511BA0AF.8040904@compulab.co.il>
 <CAD6h2NRO6N1pRfq_=ybj5TSwC7gieYOffcQmfTyUiP5R_3fWig@mail.gmail.com>
 <511CADE4.1000007@compulab.co.il>
 <CACRpkdazd+JyKz4rrptFkJ6RrP9+2S1oM=iPnqRdGj=m21PeGw@mail.gmail.com>
 <511CDC78.2000400@compulab.co.il>
Message-ID: <CACRpkdZSENzp+r9riK=0Kmg4t52BJO31pfOx3SKkz9vh8yu0Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 1:45 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:

> In order to merge this patch, we need to either remove
> the static PXA_GPIO_TO_IRQ macros and alike, or teach the IRQ_DOMAIN
> somehow to know about these.
> I don't know what from the above is easier to do, as I did not looked
> deeper into this.

I think it's quite easy to get the irqdomain in place and working
correctly. It's intended to solve exactly this kind of thing.

> I might have some time to look into this in two weeks from now,
> but I guess it will be too late as Haojian wants this patch set
> to go into 3.9.

This patch as outlined by me in the previous comments, with a
complete working irqdomain is welcome if you can get it tested.

Yours,
Linus Walleij
