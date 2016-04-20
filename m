From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 20 Apr 2016 13:12:05 +0900
Subject: [PATCH 00/50] pinctrl: Add and use devm_ apis for
 pinctrl_{register, unregister}
In-Reply-To: <CACRpkdYQL0HUWuz882RRsSu5hLoS5VcVvpm1LeL1aeJkE_Y0tA@mail.gmail.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <CACRpkdZjv2KZ0AtC9oBytmSdS+=T+kC8PoJVt-RawE8Np8p40w@mail.gmail.com>
 <56D307CC.2050202@nvidia.com> <56E031CA.9010204@nvidia.com>
 <CACRpkdYQL0HUWuz882RRsSu5hLoS5VcVvpm1LeL1aeJkE_Y0tA@mail.gmail.com>
Message-ID: <CAK7LNARUxy_ACa77t7ZZy4NqK6WOoKBqghy8YgyHg2Q0vLiymA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

2016-03-15 17:31 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> On Wed, Mar 9, 2016 at 3:23 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
>
>>> Pushed the change at:
>>> Branch "devm_pinctrl_register" of
>>> https://github.com/ldewangan/linux-upstream.git.
>>>
>>> Base repo is
>>> for-next of
>>> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
>>>
>>>
>>> If required, I can send the V2 version of list with acks.
>>
>> Let me know if I need to send full series (V2 with collected ack) again or
>> fine to pull it from above location.
>
> Please collect the ACKs on your branch and ask me to pull it after v4.6-rc1.
> No need to resend the patches.
>
> Unfortunately it arrived too late for the merge window, but hey: we got the
> devm gpiochip in for v4.6.


Not pulled yet?

I want to do my development on top of the devm_pinctrl_register series.



-- 
Best Regards
Masahiro Yamada
