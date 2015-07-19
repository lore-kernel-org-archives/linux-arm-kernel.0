From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 19 Jul 2015 13:19:43 +0900
Subject: [PATCH v2 1/7] pinctrl: UniPhier: add UniPhier pinctrl core
 support
In-Reply-To: <CACRpkdZFfypZfDAmULcC1_q_bYD-nsh2H0rMAqo+ncWsBx6m=A@mail.gmail.com>
References: <1436841607-7556-1-git-send-email-yamada.masahiro@socionext.com>
 <1436841607-7556-2-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdZFfypZfDAmULcC1_q_bYD-nsh2H0rMAqo+ncWsBx6m=A@mail.gmail.com>
Message-ID: <CAK7LNARjFdM6du3tM7RfdXEHktM=4z6XrYag9DM-z+Y0o79jNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,



2015-07-16 16:20 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Jul 14, 2015 at 4:40 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>
>> The core support for the pinctrl drivers for all the UniPhier SoCs.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> Changes in v2:
>>   - drop vogus THIS_MODULE because this file is always built-in
>>   - drop vogus "include <linux/module.h> because this file is
>>     always built-in
>
> This looks nice and uses all generic facilities we have.
>
> Patch applied.
>
> Yours,
> Linus Walleij
>



I saw the applied patch and noticed "Changes in v2"
was moved to git-description.


commit 6e908892025885b07e804dc6c05aab6ce1e06832
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue Jul 14 11:40:01 2015 +0900

    pinctrl: UniPhier: add UniPhier pinctrl core support

    The core support for the pinctrl drivers for all the UniPhier SoCs.

    Changes in v2:
      - drop vogus THIS_MODULE because this file is always built-in
      - drop vogus "include <linux/module.h> because this file is
        always built-in

    Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>




Do we need to record such stuff in the git history?

In my opinion, the difference between patch versions
should be mentioned to help reviewers, but not included in the git repository.

Early versions are often so immature that they must be improved
in the review process.
No point to record what was updated from those versions, I think.

This is why I put "changed in v2" below the "---".



-- 
Best Regards
Masahiro Yamada
