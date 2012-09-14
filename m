From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Sep 2012 16:01:56 +0200
Subject: [PATCH 01/19] ARM: ux500: Add skeleton Device Tree for the HREF
 reference board
In-Reply-To: <20120914093715.GM3374@gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-2-git-send-email-lee.jones@linaro.org>
 <CACRpkdbWVjiqrehj_v7M=cgnytEio5whTXOcax5wo0YSRe=-yA@mail.gmail.com>
 <20120914093715.GM3374@gmail.com>
Message-ID: <CACRpkdauwbEswOAwTo9G21V5Ff8XFzdt7Y+aw9W2JYqfBs=y8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 11:37 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, Sep 10, 2012 at 01:47:09AM -0700, Linus Walleij wrote:
>> On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>> > First commit applying the new Device Tree for ST-Ericsson's u8500
>> > based hardware reference board.
>> >
>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>
>> > +/dts-v1/;
>> > +/include/ "dbx5x0.dtsi"
>>
>> This include is not even in linux-next, is this patch series dependent
>> on some other series I have not seen, or that I have forgot that
>> I saw (and even possibly ACKed...)
>
> Yes, all of the above.
>
> I have them all here locally. Will test push something today hopefully.

OK then, when I see the complete set I will probably get the context.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
