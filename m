From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2012 15:06:32 +0100
Subject: [PATCH 02/14] ARM: SPEAr13xx: DT: Add spics gpio controller nodes
In-Reply-To: <CAKohpon=AVGZmR_cwUZ4=buw0kr3JVtXh51BtXteWkJ7E-f_bQ@mail.gmail.com>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
 <58a7d91cab20b924784fb5a09e16ca08e6f13318.1352608333.git.viresh.kumar@linaro.org>
 <CACRpkdZkgmLF8TxFCZSubP+g+6_ofZugArKtE9=dYTZfemstrw@mail.gmail.com>
 <CAKohpon=AVGZmR_cwUZ4=buw0kr3JVtXh51BtXteWkJ7E-f_bQ@mail.gmail.com>
Message-ID: <CACRpkdaJ2kCYfSP=xCRQAG2wDnkMKX9fey+ByhDDiOS==u+XwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 3:34 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On Nov 13, 2012 7:38 PM, "Linus Walleij" <linus.walleij@linaro.org> wrote:
>> On Sun, Nov 11, 2012 at 5:39 AM, Viresh Kumar <viresh.kumar@linaro.org>
>> wrote:

>> >         ahb {
>> > +               spics: spics at e0700000{
>> > +                       compatible = "st,spear-spics-gpio";
>> > +                       reg = <0xe0700000 0x1000>;
>> > +                       st-spics,peripcfg-reg = <0x3b0>;
>> > +                       st-spics,sw-enable-bit = <12>;
>> > +                       st-spics,cs-value-bit = <11>;
>> > +                       st-spics,cs-enable-mask = <3>;
>> > +                       st-spics,cs-enable-shift = <8>;
>> > +                       gpio-controller;
>> > +                       #gpio-cells = <2>;
>> > +               };
>> > +
>>
>> Are these bindings documented?
>
> The main patch waiting for ur comments is 1/14.

I seldom comment on individual DT bindings, I just want
to know that they're there :-)

Yours,
Linus Walleij
