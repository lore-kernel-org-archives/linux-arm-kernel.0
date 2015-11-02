From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 2 Nov 2015 15:40:10 +0100
Subject: [PATCH 19/22] clocksource/drivers/prcmu: Fix Kconfig and add
 COMPILE_TEST option
In-Reply-To: <1446469011-22710-19-git-send-email-daniel.lezcano@linaro.org>
References: <1446469011-22710-1-git-send-email-daniel.lezcano@linaro.org>
 <1446469011-22710-19-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CACRpkdZXZG499JmvVjQHrWP06kJTkGE=J+ZV4WGNn3WLvbsujg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 2, 2015 at 1:56 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> Let the platform's Kconfig to select the clock instead of having a reverse
> dependency from the driver to the platform options.
>
> Add the COMPILE_TEST option for the compilation test coverage.
>
> This change is debatable as the option itself in the Kconfig allows to
> select the driver for the platform or not. This change will make the prcmu
> timer always selected.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please merge this into the clksrc tree.

Yours,
Linus Walleij
