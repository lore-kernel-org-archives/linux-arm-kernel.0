From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 11 Apr 2013 10:13:06 +0800
Subject: [PATCH 1/3] ARM: pxa: remove cpu_is_xxx in gpio driver
In-Reply-To: <CACRpkdbr=VT8g03S=KUMUReJe+6aU0n1Pfy2nk=XErKfYojwBw@mail.gmail.com>
References: <1365556707-9159-1-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdbr=VT8g03S=KUMUReJe+6aU0n1Pfy2nk=XErKfYojwBw@mail.gmail.com>
Message-ID: <CAD6h2NTjQGyqqFwAHHimXmvCbrm60rssrP1Ys4SSa4TymrXyJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 April 2013 04:59, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Apr 10, 2013 at 3:18 AM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>
>> Avoid to use cpu_is_xxx() in pxa gpio driver. Use platform_device_id
>> to identify the difference.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I guess this will go through some PXA/MMP tree?
>
> Yours,
> Linus Walleij

Yes, I hope it go through PXA tree.

Regards
Haojian
