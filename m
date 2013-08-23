From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Aug 2013 20:11:02 +0200
Subject: [PATCH v7 3/7] gpio: samsung: Skip initialization if device tree
 is present
In-Reply-To: <1c9a01ce9f1e$473b58b0$d5b20a10$@org>
References: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
 <1377120111-25601-4-git-send-email-tomasz.figa@gmail.com>
 <CACRpkda2ZjPm4nEeDujPWSDCNLk4mr9izPvhqNKx5urVAg_Azg@mail.gmail.com>
 <3452017.UPhKO6xNO5@flatron> <1c9a01ce9f1e$473b58b0$d5b20a10$@org>
Message-ID: <CACRpkdZX96YUpCn8_vkFsZQK2q5asHtxYtaHR2y1hDK_QQs6iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 11:59 AM, Kukjin Kim <kgene@kernel.org> wrote:
> Tomasz Figa wrote:
>> On Thursday 22 of August 2013 01:21:25 Linus Walleij wrote:
>> > On Wed, Aug 21, 2013 at 11:21 PM, Tomasz Figa <tomasz.figa@gmail.com>
>> wrote:
>> > > Since this driver does not handle GPIO on device tree enabled
>> > > platforms
>> > > any more, it should be bypassed whenever device tree is available, to
>> > > not conflict with the new pinctrl-samsung driver.
>> > >
>> > > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
>> >
>> > This seems like something I should apply to the GPIO tree
>> > right now, shall I?
>>
>> Would be nice, but since this patch is a dependency for rest of this
>> series and there are no other dependencies on GPIO tree, it might be
>> easier to just let Kukjin take all the patches with required Acks.
>>
> Oh, I didn't see any dependencies...but if so, Linus do you agree with
> Tomasz' opinion?

Yes please merge it through the Samsung tree.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
