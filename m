From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Tue, 3 Apr 2012 10:53:01 +0200
Subject: [PATCH] ARM: at91: add support for Telit GE863-PRO3 Evaluation Kit
In-Reply-To: <20120330142300.GC8116@game.jcrosoft.org>
References: <1333097816-8641-1-git-send-email-fabio.porcedda@gmail.com>
 <20120330115906.GM7757@game.jcrosoft.org>
 <CAHkwnC8bErK-HX6=c_P4LY3BqncbLnoWc6=RnXaNtA8XtjHtaQ@mail.gmail.com>
 <20120330142300.GC8116@game.jcrosoft.org>
Message-ID: <CAHkwnC_QORRK8ME4bK813pVLWrQFJM0xkwATUohJg0o448pTJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 4:23 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 15:01 Fri 30 Mar ? ? , Fabio Porcedda wrote:
>> On Fri, Mar 30, 2012 at 1:59 PM, Jean-Christophe PLAGNIOL-VILLARD
>> <plagnioj@jcrosoft.com> wrote:
>> > tks for the patch but now we have close the non dt board for this soc
>>
>> Thanks for the reply.
>>
>> > and for 3.5 nearly all the devices of this soc will converted to DT
>> >
>> > so you need to switch to DT too
>>
>> Ok, i will switch to DT too.
>> Do you plan to add support to any 9260 board to the board-dt.c for 3.5?
>> I think that, as far as there is a working 9260 board using DT, i can
>> work on the GE863-PRO3 support using DT.
> you have 9g20 as 9g20 and 9260 have the same IP you can use it

Ok i try with the 9g20 support.

> I don't known when I'll put one bbut it will be a Calao platform
>
> Best Regards,
> J.
>>
>> > As today I've not finished the pinctrl support you need to do all the pin mux
>> > in the bootlader. For 3.5 it will not be the case anymore

I think i wait for the 3.5 uptated dt stuff.

>> > Best Regards,
>> > J.

Thanks and regards
-- 
Fabio Porcedda
