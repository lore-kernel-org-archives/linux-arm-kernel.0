From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 8 Oct 2013 21:14:09 +0800
Subject: [PATCH 3/3] pinctrl: sirf: add USB1/UART1 pinmux usb/uart share
In-Reply-To: <CACRpkdaX5jtA2O52zTG-3skZzO3KznRMfxFc16uL88nLQ1MG2A@mail.gmail.com>
References: <1380464879-19897-1-git-send-email-Baohua.Song@csr.com>
 <1380464879-19897-3-git-send-email-Baohua.Song@csr.com>
 <CACRpkdaX5jtA2O52zTG-3skZzO3KznRMfxFc16uL88nLQ1MG2A@mail.gmail.com>
Message-ID: <CAGsJ_4xXAHcZ_kyw8J6MHtCRa6E1Dn27DJked7KByS+3LAB_fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/10/8 Linus Walleij <linus.walleij@linaro.org>:
> On Sun, Sep 29, 2013 at 4:27 PM, Barry Song <21cnbao@gmail.com> wrote:
>
>> From: Rong Wang <Rong.Wang@csr.com>
>>
>> dn and dp of USB1 can share with UART1(UART1 can route rx,tx to dn and dp pins of USB1).
>> here we add this pinmux capability.
>> USB1/UART1 mode selection has dedicated control register in RSC module, here we attach
>> the register offset of private data of related pin groups.
>>
>> Signed-off-by: Rong Wang <Rong.Wang@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> Patch applied to the pinctrl tree as well.
>
> Now I *really* hope you're not going to send something
> upstream through the ARM SoC tree that collides with this
> because then it's better if I ACK the patches instead.
>

Linus, thanks! there is no conflict for the moment.

> But for now they are in the pinctrl tree.
>
> Yours,
> Linus Walleij

-barry
