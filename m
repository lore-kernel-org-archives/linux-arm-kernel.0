From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Aug 2013 21:59:04 +0200
Subject: [PATCH 2/2] pinctrl: sunxi: Add spinlocks
In-Reply-To: <20130807191640.GG2911@lukather>
References: <1375612728-20501-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375612728-20501-3-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdYS-7MPTTSg4psJ3NZ_jhA15aMeFLoxFNAN7hSqe4hRTA@mail.gmail.com>
 <20130807191640.GG2911@lukather>
Message-ID: <CACRpkdarfjs-RVb9VFb1vkiFsnnnv5rgTzbB1ru92B3G5MrxUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 7, 2013 at 9:16 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

>> This does not apply to my fixes branch which is based off
>> v3.11-rc4.
>
> I think you're missing this patch that I sent previously:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/186342.html

Ah OK applied that too.

>> It is also too big to go into fixes.
>>
>> I think it may be requiring the other queued Allwinner things,
>> so it is better if I apply this on the devel branch after looking over
>> that Allwinner A20/A31 stuff?
>
> The A20/A31 stuff shouldn't conflict with this one, but yes, I you
> prefer to do it that way, it's fine for me.

I applied it for fixes anyway. Too much to worry about with the
cross dependency between fixes and devel otherwise.

Yours,
Linus Walleij
