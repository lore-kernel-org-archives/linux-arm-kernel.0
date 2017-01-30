From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Jan 2017 09:26:56 +0100
Subject: [PATCH] mmc: core/mmci: restore pre/post_req behaviour
In-Reply-To: <CAPDyKFomNHTPMDUT_CUjQuG-goTuQoXqzn+vOgdP9njUTWjGXg@mail.gmail.com>
References: <20170127140454.7990-1-linus.walleij@linaro.org>
 <CAPDyKFomNHTPMDUT_CUjQuG-goTuQoXqzn+vOgdP9njUTWjGXg@mail.gmail.com>
Message-ID: <CACRpkdadrTRkfq06Q+WQ=tQtb4WRicE62E4ahzzdmgPCcNbW5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 3:18 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Do you think this is material for stable, or we could just see it as
> an improved behaviour of the core and mmci?

It's not regressing anything so just put it in for next, no hurry.

The important thing is to get rid of it from core for the future.

Yours,
Linus Walleij
