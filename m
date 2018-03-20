From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Mar 2018 04:10:19 +0100
Subject: [PATCH 07/10] ARM: dts: gemini: Remove "cooling-{min|max}-level"
 for gpio-fan node
In-Reply-To: <01ddf0ac8962feb63e8871a2c2c3498c763f649b.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <01ddf0ac8962feb63e8871a2c2c3498c763f649b.1518166039.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkdaQtPOJCcXoVB0UufLDNhkkh4__XTT2sapAKWDu9jw73g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 9, 2018 at 9:58 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> gpio-fan cooling device is found by referring to the
> "gpio-fan,speed-map" instead.
>
> Remove the unused properties from the gpio-fan node.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I can queue it next week (different machine hosting the git tree)
but it is also OK if the ARM SoC maintainers want to pick it
directly for the ARM SoC DTS branch.

Yours,
Linus Walleij
