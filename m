From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 23 Mar 2014 11:13:20 +0100
Subject: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for
 R8A7790
In-Reply-To: <532C5ADE.4030708@cogentembedded.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
 <1395397968-6242-7-git-send-email-phil.edworthy@renesas.com>
 <532C5ADE.4030708@cogentembedded.com>
Message-ID: <CAMuHMdVMCeZwX_67ktCYcYLe_P3+X5EeRbUDT3ZJjcgvU=Hwqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 4:29 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> +
>> +       pcie: pcie at fe000000 {
>> +               compatible = "renesas,r8a7790-pcie";
>
>    The convention adopted on this list is to put the "pcie" first, and SoC
> name the last.

Except for clock bindings ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
