From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Feb 2016 10:29:13 +0100
Subject: [PATCH] pinctrl: mediatek: guard sub-directory with
 CONFIG_PINCTRL_MTK
In-Reply-To: <CAK7LNAQ_8o0FiRpb7D6RBmA+7WxRMFhWJjo2f4E_NH5qAGYb4A@mail.gmail.com>
References: <1453563204-30407-1-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdbrJ5P8Ro4RQUquMOTuXhN+54ZHYGbLqrbwW6tbwCC7Mg@mail.gmail.com>
 <CAK7LNAQ_8o0FiRpb7D6RBmA+7WxRMFhWJjo2f4E_NH5qAGYb4A@mail.gmail.com>
Message-ID: <CACRpkdaA37GXf8c=EznSpocLp33CaU8dYqb8V0pua4dVfZa_2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 5:22 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Linus
>
> 2016-01-27 23:11 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
>> On Sat, Jan 23, 2016 at 4:33 PM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>
>>> CONFIG_PINCTRL_MTK is more suitable than CONFIG_ARCH_MEDIATEK
>>> to guard the drivers/pinctrl/mediatek/ directory.
>>> (I renamed CONFIG_PINCTRL_MTK_COMMON to CONFIG_PINCTRL_MTK.)
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>
>> This patch does not apply to linux v4.5-rc1, please rebase the
>> patch and resend.
>
>
> These two patches can be applied in this order:
> https://patchwork.kernel.org/patch/8097541/
> https://patchwork.kernel.org/patch/8097551/
>
> (Sorry, I should have sent them as a series.)

No order works for me and I have merged quite a lot of other stuff
that had higher priority.

But please rebase both patches on my "devel" branch and resend
and I will apply them.

Yours,
Linus Walleij
