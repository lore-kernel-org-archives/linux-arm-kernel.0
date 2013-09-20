From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Sep 2013 22:56:41 +0200
Subject: [PATCH 17/26] ARM: nomadik: remove custom .init_time hook
In-Reply-To: <1379526839-14798-18-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-18-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdYbHviadFn9Z9En6yA=smtw87fTSna13QtQHgFgub=+=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 7:53 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> remove custom .init_time hooks.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
