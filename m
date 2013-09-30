From: olof@lixom.net (Olof Johansson)
Date: Mon, 30 Sep 2013 09:07:09 -0700
Subject: [GIT PULL] ux500 device tree changes for v3.13 take 2
In-Reply-To: <CAOesGMgrX+j7UvtYuN68hk0-qaNtZ_-LkBqeXU1fTp86td4fkg@mail.gmail.com>
References: <CACRpkdYdguwxau-NRRP1mEOzdRTecYuz+RV_j7-VCEUTK-NN3w@mail.gmail.com>
 <CAOesGMgrX+j7UvtYuN68hk0-qaNtZ_-LkBqeXU1fTp86td4fkg@mail.gmail.com>
Message-ID: <CAOesGMhi=3C1CACYKTdNxQfOi8NAzyuv5-jwBSYPRJU9mMdcWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 7:44 AM, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Sep 26, 2013 at 3:45 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> Hi ARM SoC folks,
>>
>> This is a second version of the pull request from yesterday, now
>> with a (hopefully) sanitized history, and a patch on top of it fixing
>> a build problem that I just sent out.
>>
>> Please pull this in for v3.13!
>
> Hi,
>
> I've pulled in this.
>
> In the future, please squash down some of these patches when you apply
> them, there's really no point in splitting them up this much in the
> tree.

I just noticed that snowball doesn't boot with u8500_defconfig due to
this branch. Not so strange maybe since appended dtb support isn't
enabled. I'll add a patch on top for that.

Also, snowball is spewing a lot of errors about i2c devices now, looks
like the device tree contents isn't correct. I think these have shown
up with multi_v7_defconfig in the past as well but I didn't notice.
Something to look at on a rainy day.


-Olof
