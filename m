From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Apr 2017 01:09:22 +0200
Subject: [PATCH 3/3 v5] iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC
In-Reply-To: <46160aa5-f4f0-56a9-7105-50469b9089d1@kernel.org>
References: <20170404120819.6921-1-linus.walleij@linaro.org>
 <20170404120819.6921-3-linus.walleij@linaro.org>
 <46160aa5-f4f0-56a9-7105-50469b9089d1@kernel.org>
Message-ID: <CACRpkdbrxaosJd9+GRY-cCbAdEX6E6nX+SNuxVimyPTNR5T2=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 8, 2017 at 6:47 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> If you have time, it would be great to make these build
> with COMPILE_TEST to get some better build coverage in general..
> I bodged it in for the MFD and it works but there may be other
> hidden dependencies.

That's what I did too. I'll make a proper patch and send to Lee
and see what happens in the autobuilders if we do that.

Yours,
Linus Walleij
