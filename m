From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Sep 2013 21:50:59 +0200
Subject: [PATCH 0/8] IOP GPIO refactoring
In-Reply-To: <20130913161710.GA22033@blackmetal.musicnaut.iki.fi>
References: <1378741198-12847-1-git-send-email-linus.walleij@linaro.org>
 <20130910141434.GD3379@blackmetal.musicnaut.iki.fi>
 <CACRpkdYbHTF0XGu-wLAeaw-nnSTEPh-ej9iizMbojmB8gzvb=Q@mail.gmail.com>
 <20130913161710.GA22033@blackmetal.musicnaut.iki.fi>
Message-ID: <CACRpkdZHt7b10mNz6+8UYHE7BT81whU-8uwTU6HiOh8H-AKHvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 6:17 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> On Fri, Sep 13, 2013 at 10:15:58AM +0200, Linus Walleij wrote:
>> On Tue, Sep 10, 2013 at 4:14 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>> > With patch 6 it starts to crash on first gpio_get_value(), I guess
>> > because gpio-iop platform device is not registered on N2100...?
>>
>> I think I've fixed this with the v2 versions of patches 1-3, you can
>> pull in and test the entire stack on Torvalds HEAD from here:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git iop-cleanup
>
> It's still crashing.

Hm I've missed a couple of boards, I misunderstood the arrangement
of files here, let me iterate the set.

Yours,
Linus Walleij
