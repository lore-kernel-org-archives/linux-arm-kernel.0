From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Mar 2013 01:49:33 +0100
Subject: [PATCH v5 00/12] enhance DT support on gpio pxa
In-Reply-To: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdYtKBMRsFgBEEhiAykKU28RrM1USuD4SiRcASvaNeDDrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 25, 2013 at 4:49 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Changelog:
>
> v5:
> * Replace of_find_property() by of_property_read_bool().
> * Rename __gpio_is_occupied() & __gpio_is_inverted().
> * Avoid to use pxachip as variable name. Use chip instead.

Bah I've been talking crap in my other comments. This series
looks great. Acked-by: Linus Walleij <linus.walleij@linaro.org>
for the entire series (but I have a comment on patch 12/12,
even though I Ack it).

Will you take this through the PXA tree?

Yours,
Linus Walleij
