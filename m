From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Feb 2013 16:24:37 +0100
Subject: [PATCH v8 06/12] pinctrl: single: create new gpio function range
In-Reply-To: <1360602659-4774-7-git-send-email-haojian.zhuang@linaro.org>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
 <1360602659-4774-7-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdbt440_nJHzKrW=WKHyTvPQHYg3N3B-1MA=VOGBwrB44g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 6:10 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Since gpio driver could create gpio range in DTS, it could invokes
> pinctrl_request_gpio(). In the pinctrl-single driver, it needs to
> configure pins with gpio function mode.

Is it OK if I wait with patches 6-12 while we sort out the first
5?

Yours,
Linus Walleij
