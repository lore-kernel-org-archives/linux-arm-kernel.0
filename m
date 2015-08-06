From: alexey@kopytko.ru (Alexey Kopytko)
Date: Thu, 6 Aug 2015 09:33:12 +0900
Subject: [PATCH v2] ARM: dts: Convert Linkstation Mini to Device Tree
In-Reply-To: <55C23FA8.9030504@free-electrons.com>
References: <1436885641.7145.9.camel@dolka.fr> <20150718185238.GH17961@lunn.ch>
 <55B396A1.1090509@free-electrons.com>
 <1438027893.15635.41.camel@dolka.fr>
 <55C23FA8.9030504@free-electrons.com>
Message-ID: <CAO10ksyxsZ=Xv4iPn4uSjTC1z9D6dR9hZq6Mk7yuMJhFin9ZhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 6, 2015 at 1:54 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

>>> With the Acked-by from  Andrew Lunn I am ready to apply your patch.
>>> However for the device tree I need the acked-by from Thomas Petazzoni but I
>>> am sure he will give it as he already agreed for the armada-*.dts* files.
>>>
>>> I am not sure we need the formal acked-by from Alexey because the dts is
>>> not based on a dts written by him.
>>
>> It's just that I took all the devices definition from his .c; to me, it
>> counts as derived work, but IANAL.
>
> For me it is still the decription of the hardware not an derivated work.
> Andrew what is your opinion on it?
>
> But if we consider it as a derivated work then we need Alexey acked-by soon,
> or going back to GPL only license.
>

Since the patch touches files I had a part creating, the patch itself
is clearly a derivative work. Therefore, without further ado...

Acked-by: Alexey Kopytko <alexey@kopytko.ru>


Thanks,

-Alexey
