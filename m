From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 Feb 2013 13:43:10 +0100
Subject: [PATCH] rtc: pl031: fix the missing operation on enable
In-Reply-To: <CAD6h2NQ6M6hmPE2anH2jkhBtc5HfQXLMxJTtLQEh9p8V1kNMhQ@mail.gmail.com>
References: <1359507865-29808-1-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkda_0Uat=Qs3ty38Ygbsucx6dL0J+PmxVq7N_gRzQsEhbw@mail.gmail.com>
 <CAD6h2NQ6M6hmPE2anH2jkhBtc5HfQXLMxJTtLQEh9p8V1kNMhQ@mail.gmail.com>
Message-ID: <CACRpkdb_AwcczLXEb0KS1ZO=5xdM3K6UDvkwT6-=f5H5fJzyeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 4, 2013 at 1:34 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> I prefer you can submit a follow up patch.

OK!

> And I think that you can
> use a compatible
> name to distinguish from original "arm,rtc-pl031". Then we can get two
> branches to
> handle the difference in the probe function. What's your opinion?

No that is wrong for PrimeCells.

PrimeCells have special ID numbers that we use to identify the
different variants already.

Yours,
Linus Walleij
