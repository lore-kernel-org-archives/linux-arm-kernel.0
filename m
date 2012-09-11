From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Sep 2012 19:55:40 +0200
Subject: [PATCH 2/2] pinctrl: mvebu: remove dead code
In-Reply-To: <1347373204-17883-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347373204-17883-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1347373204-17883-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdZLi2pHOmjBwzwoxYC6=hq+Q3fxDRUt-oCs1yzj5-io2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 4:20 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> -#if 0
> -struct mvebu_pinctrl_function *mvebu_pinctrl_find_function_by_name(
> -       struct mvebu_pinctrl *pctl, const char *name)
> -{
> -       unsigned n;
> -       for (n = 0; n < pctl->num_functions; n++) {
> -               if (strcmp(name, pctl->functions[n].name) == 0)
> -                       return &pctl->functions[n];
> -       }
> -       return NULL;
> -}
> -#endif

Grrr how could I miss this...?

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
