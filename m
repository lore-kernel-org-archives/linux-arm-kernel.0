From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon, 24 Feb 2014 15:56:36 +0100
Subject: [PATCH v3 6/7] pinctrl: at91: implement get_direction
In-Reply-To: <CACRpkdZN_fT05+1JCJ2bemN3KfpfFFWu__HQcL9Sz7n2M9gCnw@mail.gmail.com>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
 <1392656247-3351-7-git-send-email-richard.genoud@gmail.com>
 <CACRpkdZN_fT05+1JCJ2bemN3KfpfFFWu__HQcL9Sz7n2M9gCnw@mail.gmail.com>
Message-ID: <CACQ1gAi+rSvuRzCQiyV4QT0V75CccwH7iSEBRMyDdF_1W63OKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-02-24 15:44 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
> On Mon, Feb 17, 2014 at 5:57 PM, Richard Genoud
> <richard.genoud@gmail.com> wrote:
>
>> This is needed for gpiod_get_direction().
>> Otherwise, it returns -EINVAL.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Can I apply this directly to the pinctrl tree or do you want it to
> go through AT91 ARM SoC with the rest of these patches
> or something?

Well, I guess you can apply it on pinctrl tree.

I'll comme with an updated version of patches 1,4,7 soon, and I'll
write clearly in the cover letter the needed patches, and the tree
they're in to prevent breaking the compilation.

thanks !
