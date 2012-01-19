From: veli-pekka.peltola@bluegiga.com (Veli-Pekka Peltola)
Date: Thu, 19 Jan 2012 13:40:24 +0200
Subject: [PATCH v3] ARM: support XZ compressed kernels
In-Reply-To: <op.v4vsotxk2s3iss@ecaz>
References: <1320696216-5570-1-git-send-email-kaloz@openwrt.org>
 <CACRpkdb1RhmB4d2DfWp4B3OVybt-NMnku-fo+bHDuPWdi9LddQ@mail.gmail.com>
 <op.v4vsotxk2s3iss@ecaz>
Message-ID: <4F180128.9060005@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/13/2011 12:56 PM, Imre Kaloz wrote:
> On Sat, 12 Nov 2011 11:50:02 +0100, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>
>> On Mon, Nov 7, 2011 at 9:03 PM, Imre Kaloz <kaloz@openwrt.org> wrote:
>>
>>> Wire up support for the XZ decompressor
>>>
>>> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
>>
>> Looks useful.
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Put it in Russell's patch tracker.
>> Linus Walleij
>
> A previous version was there, but Russell applied it then dropped it,
> hence I didn't want to add it again.
>
> Russell, would you like me to add it there?
>
>
> Imre

It has been quite silent related to this patch. What is current status?

I have been using XZ in our development kernels nine months now without 
any problems on AT91 platform.

Acked-by: Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>

--
Veli-Pekka Peltola
