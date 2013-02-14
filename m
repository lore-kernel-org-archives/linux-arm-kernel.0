From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 15 Feb 2013 00:25:02 +0800
Subject: [PATCH v8 06/12] pinctrl: single: create new gpio function range
In-Reply-To: <CACRpkdbt440_nJHzKrW=WKHyTvPQHYg3N3B-1MA=VOGBwrB44g@mail.gmail.com>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
 <1360602659-4774-7-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdbt440_nJHzKrW=WKHyTvPQHYg3N3B-1MA=VOGBwrB44g@mail.gmail.com>
Message-ID: <CAD6h2NR7P=DedxF-qJ7cG4JeTUso1n4QrSCnuR8DeKGVYgJmgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 February 2013 23:24, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Feb 11, 2013 at 6:10 PM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>
>> Since gpio driver could create gpio range in DTS, it could invokes
>> pinctrl_request_gpio(). In the pinctrl-single driver, it needs to
>> configure pins with gpio function mode.
>
> Is it OK if I wait with patches 6-12 while we sort out the first
> 5?
>
> Yours,
> Linus Walleij

Since Tony has some comments on dropping BIAS_AUTO_PULL,
I'll send the v9 including your comments.

Regards
Haojian
