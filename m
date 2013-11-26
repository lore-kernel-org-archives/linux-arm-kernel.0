From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Nov 2013 09:52:56 +0100
Subject: [PATCH 2/6] arm: sa1100: h3600: refactor LCD GPIO handling
In-Reply-To: <1385048414-9812-3-git-send-email-dbaryshkov@gmail.com>
References: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
 <1385048414-9812-3-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkdZCxLuUMKbm+faxvTMrEjSq76orf=7y1CUX4TDsTETUzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 4:40 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> Use gpio_request_array to request all GPIOs at once. Also don't call
> gpio_free. There is little point freeing LCD gpios once they are
> requested. Instead guard them with bool variable.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
