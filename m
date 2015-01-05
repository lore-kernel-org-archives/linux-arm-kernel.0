From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 5 Jan 2015 14:30:04 +0100
Subject: [PATCH v4 1/3] ARM: shmobile: r8a7791: add CAN clocks
In-Reply-To: <CAMuHMdXmKV2_npgjaC+t4wDD6we8VCBFSzHFfkRHwELO30BMmQ@mail.gmail.com>
References: <6830301.90YaDPuTpx@wasted.cogentembedded.com>
 <2098987.LzjA3c0AUx@wasted.cogentembedded.com>
 <CAMuHMdXmKV2_npgjaC+t4wDD6we8VCBFSzHFfkRHwELO30BMmQ@mail.gmail.com>
Message-ID: <CAMuHMdUFrOeuR8N67pcp6kPEE1G94DUgU7iDLX2QRL3GbvkXtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 5, 2015 at 2:29 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sat, Dec 27, 2014 at 12:18 AM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
>> The R-Car CAN controllers can derive the CAN bus clock not only from their
>> peripheral clock input (clkp1) but also from the other internal clock (clkp2)
>> and external clock fed on CAN_CLK pin.  Describe those clocks in the device
>> tree,  along with  the USB_EXTAL clock  from which clkp2 is derived.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> Acked-by: arch/arm/boot/dts/r8a7790.dtsi

Bummer...

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
