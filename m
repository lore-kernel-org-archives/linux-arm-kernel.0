From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Apr 2016 16:18:20 +0200
Subject: [RFC v5 3/4] gpio: move clps711x, moxart,
 ts4800 and gpio-ge into gpio-generic
In-Reply-To: <9e5cc9e957144bd5d4081573ef959f931281eaaa.1461888822.git.chunkeey@googlemail.com>
References: <cover.1461888822.git.chunkeey@googlemail.com>
 <9e5cc9e957144bd5d4081573ef959f931281eaaa.1461888822.git.chunkeey@googlemail.com>
Message-ID: <CACRpkdaX1xeGJxV9K-GkTAh87SctqyhkJ+VN6mwUdtD19tz99g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 2:53 AM, Christian Lamparter
<chunkeey@googlemail.com> wrote:

> This patch integrates these GPIO drivers into gpio-generic.
>
> Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>

Very elegant. Let's wait for some feedback/ACKs from
the driver maintainers, but this looks very nice.

Do you want to address Andy's optimization suggestion directly
or as a follow-on patch?

Yours,
Linus Walleij
