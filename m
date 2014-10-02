From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 2 Oct 2014 09:18:21 +0200
Subject: [PATCH 0/5] pinctrl: samsung: Data structure clean-up
In-Reply-To: <5426B289.7070802@gmail.com>
References: <1411499141-26551-1-git-send-email-tomasz.figa@gmail.com>
 <CACRpkdZCMD4x+wrvTOrrWK-Dy4_rg6bD2xUAA4jtTGTbT1uDag@mail.gmail.com>
 <5423C904.60708@gmail.com> <5426B289.7070802@gmail.com>
Message-ID: <CACRpkdY4yXZ4NeCnZkdeBSto6oX2q_svxkr6Six29aKwPm-xjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 2:50 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On 25.09.2014 09:49, Tomasz Figa wrote:
>> On 25.09.2014 09:47, Linus Walleij wrote:
>>> On Tue, Sep 23, 2014 at 9:05 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>>
>>>> This series intends to clean up data structures used by pinctrl-samsung driver.
>>>> More specifically, it separates initial compile time constants from data used
>>>> at runtime, allowing unused variant data to be dropped and selected structures
>>>> constified to improve safety.
>>>
>>> I like the patch set, tried to apply it but patch 3/5 failed to apply to the
>>> devel branch for pinctrl.
>>>
>>> Can you rebase this on my "devel" branch, include Marek's Tested-by
>>> tag and resend, and I'll take it for v3.18.
>>
>> Sure. Will do that today evening. Probably clashed with some other
>> changes queued in the meantime.
>
> Uhm. I went back home and forgot about this series until now. Sorry.
>
> I have rebased it on your "devel" branch, although it seems like this
> branch is missing [1], which in turn seems to be already present in your
> "for-next" branch and is going to cause a merge conflict with this
> series. Should I still proceed with posting the series based on "devel"?
>
> [1] f6a8249f9e55d pinctrl: exynos: Lock GPIOs as interrupts when used as
> EINTs

Bah I must have accidentally applied the patch to my for-next
branch instead of devel, and then wiped it out of existence when
I later reset the for-next branch to devel.

Please resend all 5 rebased on devel.

Yours,
Linus Walleij
