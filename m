From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Oct 2013 10:00:47 +0200
Subject: [GIT PULL] ux500 device tree changes for v3.13 take 2
In-Reply-To: <CAOesGMhi=3C1CACYKTdNxQfOi8NAzyuv5-jwBSYPRJU9mMdcWw@mail.gmail.com>
References: <CACRpkdYdguwxau-NRRP1mEOzdRTecYuz+RV_j7-VCEUTK-NN3w@mail.gmail.com>
 <CAOesGMgrX+j7UvtYuN68hk0-qaNtZ_-LkBqeXU1fTp86td4fkg@mail.gmail.com>
 <CAOesGMhi=3C1CACYKTdNxQfOi8NAzyuv5-jwBSYPRJU9mMdcWw@mail.gmail.com>
Message-ID: <CACRpkdaC3qoMQs+WDoGQJNh6idjZp5wt=e2Ki-N8i=Q4kLpkbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 6:07 PM, Olof Johansson <olof@lixom.net> wrote:

> I just noticed that snowball doesn't boot with u8500_defconfig due to
> this branch. Not so strange maybe since appended dtb support isn't
> enabled. I'll add a patch on top for that.

Aha yes unless you know a way to update the U-boot to load
each pice (I don't) then this is needed...

> Also, snowball is spewing a lot of errors about i2c devices now, looks
> like the device tree contents isn't correct. I think these have shown
> up with multi_v7_defconfig in the past as well but I didn't notice.
> Something to look at on a rainy day.

I think Lee is looking into this, and I have the same problems on
the HREF where I try to fix things up. It'd not harmful and mainly
due to over-registration of a superset of devices, so the DTS files
need to be made more specific for each hardware.

Yours,
Linus Walleij
