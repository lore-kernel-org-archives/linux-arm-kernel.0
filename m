From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 13 Jul 2016 11:20:00 +0300
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAyLzJdIHNwaTogYWRkIERUIGJpbmRpbmcgZm9yIGNs?=
 =?UTF-8?B?cHM3MTF4IFNQSQ==?=
In-Reply-To: <9132787.CoNHcRuYpT@wuerfel>
References: <20160707094952.4111577-1-arnd@arndb.de>
 <20160712204947.GA6182@rob-hp-laptop> <9132787.CoNHcRuYpT@wuerfel>
Message-ID: <1468398000.319627182@f165.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>?????, 13 ???? 2016, 11:13 +03:00 ?? Arnd Bergmann <arnd@arndb.de>:
>
>On Tuesday, July 12, 2016 3:49:47 PM CEST Rob Herring wrote:
>> On Thu, Jul 07, 2016 at 11:49:46AM +0200, Arnd Bergmann wrote:
>> > +
>> > +An additional register is present in the system controller,
>> > +which is assumed to be in the same device tree, with and marked
>> > +as compatible with "cirrus,ep7209-syscon3".
>> > +
>> > +Example:
>> > +
>> > +spi at 80000500 {
>> > +     #address-cells = <1>;
>> > +     #size-cells = <0>;
>> > +     compatible = "cirrus,ep7209-spi";
>> > +     reg = <0x80000500 0x4>;
>> > +     interrupts = <15>;
>> > +     clocks = <&clks CLPS711X_CLK_SPI>;
>> > +     status = "disabled";
>> > +};
>> > +
>> > +syscon3: syscon at 80002200 {
>> 
>> This looks like it shouldn't be here.
>
>The label, or the entire node?

I think that the whole syscon3 node is redundant.

---
