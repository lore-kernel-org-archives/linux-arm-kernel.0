From: robh@kernel.org (Rob Herring)
Date: Wed, 4 May 2016 07:32:02 -0500
Subject: [RFC v6 1/3] gpio: dt-bindings: add wd,mbl-gpio bindings
In-Reply-To: <4330813.s9mxBLCsXA@debian64>
References: <cover.1462104492.git.chunkeey@googlemail.com>
 <103bf8fceb426a9c3b09641ea989955e3ec1c7d4.1462104492.git.chunkeey@googlemail.com>
 <20160504022210.GA9913@rob-hp-laptop> <4330813.s9mxBLCsXA@debian64>
Message-ID: <CAL_JsqLQV-k9O9SjaTnHG5G_JhYqn69xHzLWrqXJAJvGAc=2Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 11:53 PM, Christian Lamparter
<chunkeey@googlemail.com> wrote:
> On Tuesday, May 03, 2016 09:22:10 PM Rob Herring wrote:
>> On Sun, May 01, 2016 at 02:18:37PM +0200, Christian Lamparter wrote:
>> > This patch adds the device tree bindings for the Western Digital's
>> > MyBook Live memory-mapped GPIO controllers.
>> >
>> > The gpios will be supported by gpio-mmio code of the
>> > GPIO generic library.
>> >
>> > +++ b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
>> > @@ -0,0 +1,38 @@
>> > +Bindings for the Western Digital's MyBook Live memory-mapped GPIO controllers.
>>
>> Are these really product level GPIOs rather than some SOC's GPIOs
>> (APM?)?
>>
> Ah, that's a good point.
>
> In a nutshell: The APM82181 SoC has two proper/normal GPIO controllers
> which have a dt-binding and a kernel driver ready to go.
> However Western Digital went with their own GPIO controller for
> the MyBook Live [7].

Okay, just making sure. It's a little strange to have external (to an
SOC) memory mapped GPIOs is why I asked.

Acked-by: Rob Herring <robh@kernel.org>

Rob

P.S. By v6, you should drop RFC.
