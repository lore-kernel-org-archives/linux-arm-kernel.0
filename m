From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 15:26:05 +0200
Subject: [PATCH 2/2] pinctrl: samsung: Fix link error with
 CONFIG_PINCTRL_EXYNOS disabled
In-Reply-To: <2113989.KXXvDDhnMa@amdc1227>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
 <6940961.67Lk2axxPL@amdc1227>
 <CACRpkdZmSj-AqUA9kd7NMN6cL2Nxa0EaKoSVkwQSrxhcWEeQtg@mail.gmail.com>
 <2113989.KXXvDDhnMa@amdc1227>
Message-ID: <CACRpkdY61h-H14QYHhADnAz1JRa=8Wbi0aYKSRW21xm4WHOHGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 4:47 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> On Wednesday 24 of April 2013 16:27:09 Linus Walleij wrote:
>> On Tue, Apr 23, 2013 at 2:09 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>> > On Tuesday 23 of April 2013 14:03:12 Linus Walleij wrote:
>> >> This does not apply to my "devel" branch in the pinctrl tree.
>> >>
>> >> Could you rebase it on that branch?
>> >>
>> >> Or is the error not even in my tree?
>> >
>> > This one got sent incorrectly due to my mistake. Please try the correct
>> > version:
>> >
>> > [PATCH RESEND 2/2] pinctrl: samsung: Fix link error with
>> > CONFIG_PINCTRL_EXYNOS disabled
>>
>> This does not apply either.
>>
>> Can you please test against the "devel" branch in the pinctrl tree?
>
> Right, it does not apply.
>
> Well, actually it does with git am -3, but it is incorrect, since the problem
> it intends to fix is not present in your tree, but rather is a merge error in
> linux-next in a merge of Kgene's and your tree...

Oh. Then you have to send the patch to Stephen Rothwell.

Yours,
Linus Walleij
