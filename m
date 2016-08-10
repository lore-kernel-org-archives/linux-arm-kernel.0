From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Aug 2016 14:25:02 +0200
Subject: [PATCH] ARM: no need to select SMP_ON_UP explicitly
In-Reply-To: <6326645.Nr2CxIomnL@wuerfel>
References: <1469199369-25746-1-git-send-email-vladimir.murzin@arm.com>
 <20160809084416.GS4678@tiger> <57AAE5D7.2080009@arm.com>
 <6326645.Nr2CxIomnL@wuerfel>
Message-ID: <CACRpkdb1rJ0fVDFU6uJ3fscCG4ZGQXoC713uKLMcWiBc56Ht_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 10:55 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday, August 10, 2016 9:29:11 AM CEST Vladimir Murzin wrote:
>> On 09/08/16 09:44, Shawn Guo wrote:
>> > On Fri, Jul 22, 2016 at 03:56:09PM +0100, Vladimir Murzin wrote:
>> >> SMP_ON_UP is already defaulted to "y" and has all dependencies expressed
>> >> - no need to select it per platform level
>> >>
>> >> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> >> ---
>> >>
>> >> This time sent to LAKML
>> >>
>> >>  arch/arm/mach-imx/Kconfig      |    3 ---
>> >>  arch/arm/mach-realview/Kconfig |    1 -
>> >
>> > I cannot take mach-realview changes.  I think you need to ether split
>> > the changes, or ask arm-soc folks to apply.  In case of the latter, here
>> > is my ACK:
>> >
>> > Acked-by: Shawn Guo <shawnguo@kernel.org>
>>
>> Thanks!
>>
>> RealView is not mentioned under MAINTAINERS, so it'd be easier if
>> arm-soc team pick this patch.
>>
>> Arnd, what is your preference?
>
> Linus Walleij is the person that has sent most patches for realview,
> so I'll let him decide. We can pick it up directly, or he can
> aggregate it with other patches that he might have.

I have queued this with a bunch of other RealView clean-ups and board
file removal patches and will send a pull request for it shortly.

Yours,
Linus Walleij
