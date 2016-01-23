From: codekipper@gmail.com (Code Kipper)
Date: Sat, 23 Jan 2016 15:50:44 +0100
Subject: [linux-sunxi][PATCH v3 3/5] ARM: dts: sun7i: Add Itead Ibox
 support
In-Reply-To: <20160121155408.GG3997@lukather>
References: <1452766555-16409-1-git-send-email-codekipper@gmail.com>
 <1452766555-16409-4-git-send-email-codekipper@gmail.com>
 <20160118194100.GR4581@lukather>
 <CAEKpxBkTStWMNE6FT=zFLGhvxvb0Con-_idD9Oj8eKf2B5TKGg@mail.gmail.com>
 <20160121155408.GG3997@lukather>
Message-ID: <CAEKpxBkww_8HjpBNi7sUH-ixGmBLqQEPWM0kvq4tTZtbOa=7Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 January 2016 at 16:54, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Tue, Jan 19, 2016 at 08:43:34AM +0100, Code Kipper wrote:
>> >> +&spi0 {
>> >> +     pinctrl-names = "default";
>> >> +     pinctrl-0 = <&spi0_pins_a>,
>> >> +                 <&spi0_cs0_pins_a>;
>> >> +     status = "okay";
>> >
>> > What device is connected to that bus?
>>
>> These lead out to the header on the side of the box and is also
>> enabled in the fex. If we remove this we might as well remove sata as
>> that is also done via this header.
>
> AFAIK, the SATA is not muxable, so the pins on this header can only be
> used for that anyway.
>
> What I'm more concerned about is pins that are just "generic" pins
> that can have multiple functions that are not really enforced by any
> design choice.
No worries...it will be gone in the next release.
BR,
CK
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
