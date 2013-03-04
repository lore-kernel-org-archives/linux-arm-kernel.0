From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 4 Mar 2013 08:57:14 +0800
Subject: [PATCH v5 00/12] enhance DT support on gpio pxa
In-Reply-To: <CACRpkdYtKBMRsFgBEEhiAykKU28RrM1USuD4SiRcASvaNeDDrw@mail.gmail.com>
References: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdYtKBMRsFgBEEhiAykKU28RrM1USuD4SiRcASvaNeDDrw@mail.gmail.com>
Message-ID: <CAD6h2NRGQ8h8FPWbPSDMre7C5j4Zgu97RbMNwEcuShrEdME+aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 March 2013 08:49, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Feb 25, 2013 at 4:49 AM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>
>> Changelog:
>>
>> v5:
>> * Replace of_find_property() by of_property_read_bool().
>> * Rename __gpio_is_occupied() & __gpio_is_inverted().
>> * Avoid to use pxachip as variable name. Use chip instead.
>
> Bah I've been talking crap in my other comments. This series
> looks great. Acked-by: Linus Walleij <linus.walleij@linaro.org>
> for the entire series (but I have a comment on patch 12/12,
> even though I Ack it).
>
> Will you take this through the PXA tree?
>
> Yours,
> Linus Walleij

Since Grant has some comments on the platform data usage,
I'll give out the v6 later.

By the way, I'll take it through the PXA tree.

Regards
Haojian
