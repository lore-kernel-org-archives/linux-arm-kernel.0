From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 17 Jul 2015 16:57:11 +0800
Subject: [PATCH 3/6] clk: sunxi: Add A33 clock for compilation
In-Reply-To: <CAEzqOZv5pDPJgBfvNKk7vZuTr5H9hLdEOweyxStRFtarNxtFhQ@mail.gmail.com>
References: <1431240383-12763-1-git-send-email-vishnupatekar0510@gmail.com>
 <1431240383-12763-4-git-send-email-vishnupatekar0510@gmail.com>
 <20150510101750.GC11057@lukather>
 <CAEzqOZv5pDPJgBfvNKk7vZuTr5H9hLdEOweyxStRFtarNxtFhQ@mail.gmail.com>
Message-ID: <CAGb2v67NjfNjS_FQoYmEs2=OhKYRszgzuqiNPyww3UtiWCq--Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vishnu,

This patch did not make v4.2-rc1.

A33 support requires this patch. Otherwise the clock tree
is absent and nothing works.



On Mon, May 11, 2015 at 4:53 PM, Vishnu Patekar
<vishnupatekar0510@gmail.com> wrote:
> Hi,
>
> On Sun, May 10, 2015 at 3:47 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> Hi,
>>
>> On Sun, May 10, 2015 at 12:16:20PM +0530, Vishnu Patekar wrote:
>>> A33 clock control unit is similar to A23.
>>>
>>> A33 specific clocks are not yet implemented, added CLK_OF_DECLARE
>>> to get it compiled for A33.
>>
>> That commit log doesn't make any sense.
>>
>> What you're doing isn't about whether or not that will be compiled,
>> but whether you're registering the clocks and which clocks you
>> protect.
> Actually, It's just registering the a33 clocks and reusing a23 code.
> nothing to do with compile. I'll correct it in next patch version.
>>
>>> Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
>>
>> Isn't it supposed to have a space in the middle of your name, just
>> like you have in your mail address?
> Yes, There should be space.
>>
>> Thanks,
>> Maxime
>>
>> --
>> Maxime Ripard, Free Electrons
>> Embedded Linux, Kernel and Android engineering
>> http://free-electrons.com
