From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 2 Jun 2016 14:06:53 +0200
Subject: [PATCH 32/34] clk: u300: Migrate to clk_hw based registration APIs
In-Reply-To: <20160601231533.9354-33-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-33-stephen.boyd@linaro.org>
Message-ID: <CACRpkdaR1geN2WfE3EoyB5i8J-=VJWq-qhHgELsPX0EkJhFOpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 2, 2016 at 1:15 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:

> Now that we have clk_hw based provider APIs to register clks, we
> can get rid of struct clk pointers while registering clks in
> these drivers, allowing us to move closer to a clear split of
> consumer and provider clk APIs.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
