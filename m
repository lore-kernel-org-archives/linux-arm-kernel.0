From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 4 Oct 2017 13:10:26 +0200
Subject: [PATCH v2 7/8] arm64: dts: renesas: initial Eagle board device
 tree
In-Reply-To: <9ad9bd62-300c-cc78-a8f3-bbdd9eed6bed@cogentembedded.com>
References: <20170915194445.950496886@cogentembedded.com>
 <CAMuHMdUX+RW9H-p5n_JB-SkW8k5g_i0bg-i9LD59b5MLvFm3YQ@mail.gmail.com>
 <9ad9bd62-300c-cc78-a8f3-bbdd9eed6bed@cogentembedded.com>
Message-ID: <CAMuHMdUfRr-X_+pZhmWw28SDwa5=7daSefjVaT9y5cFB9VoO6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wed, Oct 4, 2017 at 1:03 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 9/21/2017 4:18 PM, Geert Uytterhoeven wrote:
>>> Add the initial device  tree for  the R8A77970 SoC based Eagle board.
>>> The board has 1 debug serial port (SCIF0); include support for it,
>>> so that the serial console can work.
>>>
>>> Based on the original (and large) patch by Vladimir Barinov
>>> <vladimir.barinov@cogentembedded.com>.
>>>
>>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>>> --- /dev/null
>>> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts

>>> +&extal_clk {
>>> +       clock-frequency = <16666666>;
>>
>>
>> Nitpicking: the schematics say 16.6666 MHz
>> At 100 ppm accuracy that's the same, though.
>
>    So, you still want me to change this freq?

I don't think that's really needed, as the difference is smaller than the
accuracy anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
