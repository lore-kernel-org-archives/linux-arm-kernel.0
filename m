From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 2 Jun 2016 14:06:11 +0200
Subject: [PATCH 20/34] clk: nomadik: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-21-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-21-stephen.boyd@linaro.org>
Message-ID: <CACRpkdYa5JqZ0ge60C6rEZ_0_0+6TCmf49WcQYtMBgeJBr7FVg@mail.gmail.com>
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
