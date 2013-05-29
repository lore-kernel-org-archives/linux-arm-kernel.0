From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 May 2013 17:46:17 +0200
Subject: [PATCH -next] dmaengine: ste_dma40: add missing iounmap() on
 error in d40_probe()
In-Reply-To: <CAPgLHd9kMzZ_ZY6zm0MZ+P6dHq73i_GdCsxhpUOt-V9nf08tWA@mail.gmail.com>
References: <CAPgLHd9kMzZ_ZY6zm0MZ+P6dHq73i_GdCsxhpUOt-V9nf08tWA@mail.gmail.com>
Message-ID: <CACRpkdZpReWCaA7=-5xPfd9y5jDfP-P+5VqFCuo4Aa7LQ31Qhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

why does the patch subject say -next?

AFAICS the patch applies to Torvalds tree as well, and should probably
go in for fixes.

On Tue, May 28, 2013 at 11:07 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Add the missing iounmap() before return from d40_probe()
> in the error handling case.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess Vinod should apply this... maybe it should even be marked
for stable.

Yours,
Linus Walleij
