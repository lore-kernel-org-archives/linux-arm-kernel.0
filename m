From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 1 Jun 2016 13:30:29 +0300
Subject: [PATCH 00/13] Add R8A7794/SILK board eMMC DT support
In-Reply-To: <CAMuHMdV4BqUC2QMX-=-R6K6gdrvkX=rUcWn_uFF-jdQuYruhbw@mail.gmail.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <CAMuHMdV4BqUC2QMX-=-R6K6gdrvkX=rUcWn_uFF-jdQuYruhbw@mail.gmail.com>
Message-ID: <ec4904b9-cf61-b396-ef6c-ded717e68ea5@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 6/1/2016 10:04 AM, Geert Uytterhoeven wrote:

>>    Here's the set of 13 patches against Simon Horman's 'renesas.git' repo,
>> 'renesas-devel-20160530-v4.7-rc1' tag. We add the device tree support for
>> the R8A7792-based Blanche board. The R-Car 'clk' driver patch was posted last
>> week separately...
>>
>> [01/13] ARM: shmobile: r8a7792: add clock index macros
>> [02/13] ARM: shmobile: r8a7792: add power domain index macros
>> [03/13] soc: renesas: rcar-sysc: add R8A7792 support
>> [04/13] ARM: shmobile: r8a7792: basic SoC support
>> [05/13] DT: clock: rcar-gen2-cpg-clocks: document R8A7792 support
>> [06/13] DT: clock: cpg-mstp-clocks: document-R8A7792-support
>> [07/13] ARM: dts: r8a7792: initial SoC device tree
>> [08/13] ARM: dts: r8a7792: add SYS-DMAC support
>> [09/13] ARM: dts: r8a7792: add [H]SCIF support
>> [10/13] ARM dts: r8a7792: add IRQC support
>> [11/13] DT: arm: shmobile: document Blanche board
>> [12/13] ARM: dts: blanche: initial device tree
>> [13/13] ARM: dts: blanche: add Ethernet support
>
> Thanks for your series!
>
> The subject doesn't seem to cover the contents, though:
>> [PATCH 00/13] Add R8A7794/SILK board eMMC DT support

    Oops. :-(
    Sorry about that...

> Gr{oetje,eeting}s,
>
>                         Geert

MBR, Sergei
