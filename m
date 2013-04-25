From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 14:56:40 +0200
Subject: [PATCH 30/32] ARM: ux500: Supply MMC DMA configuration via Device
 Tree
In-Reply-To: <20130425114931.GJ4623@gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-31-git-send-email-lee.jones@linaro.org>
 <CACRpkdbYXxkC2y9zCNcMAAmmQ7+3V0Y=hq7zgtp5L=Ts9QzpQQ@mail.gmail.com>
 <20130425114931.GJ4623@gmail.com>
Message-ID: <CACRpkdbnGbVwqnY=aPU5Jic88v7VAsDWaB0yDU3iMo=YLCd9EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 1:49 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 25 Apr 2013, Linus Walleij wrote:
>
>> On Thu, Apr 18, 2013 at 12:12 PM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>> > When requesting a channel, a DMA client needs to pass some pieces of
>> > information such as; request channel, device type, channel type and
>> > direction etc. Normally we do this in the form of platform data, but
>> > when DT is enabled we need to pass it using the driver's bindings
>> > instead.
>> >
>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>
>> This requires that the pending MMCI patch get merged *first* right?
>
> No, it doesn't. There is no harm in applying this *before*.
>
> It will just lay dormant until it is.

Ah yeah, right. But the patch stripping out the platform data (no 31) will
wreak havoc if applied before the MMCI patch right?

Yours,
Linus Walleij
