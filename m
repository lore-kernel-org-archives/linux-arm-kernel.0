From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 26 Oct 2016 16:23:33 +0300
Subject: [PATCH v4 0/7] Add R8A7743/SK-RZG1M board support
In-Reply-To: <CAMuHMdUNgnYc1O7DATNH1r9SQ72eqtxwFvqcen08Tq+Er3LuvQ@mail.gmail.com>
References: <2719479.geOc9vqcRS@wasted.cogentembedded.com>
 <CAMuHMdUNgnYc1O7DATNH1r9SQ72eqtxwFvqcen08Tq+Er3LuvQ@mail.gmail.com>
Message-ID: <1a85f851-29ec-1c14-8905-8b0645f5bb1c@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2016 03:08 PM, Geert Uytterhoeven wrote:

>>    Here's the set of 8 patches against Simon Horman's 'renesas.git' repo's
>> 'renesas-devel-20161021-v4.9-rc1' tag. I'm adding the device tree support for
>> the R8A7743-based SK-RZG1M board. The SoC is close to R8A7791 and the board
>> seems identical to the R8A7791/Porter board. The device tree patches depend on
>> the R8A7743 CPG/MSSR driver series just posted in order to compile and work.
>
> They depend only on "[PATCH v3 1/2] ARM: shmobile: r8a7743: add CPG clock
> index macros" of that series, right?
>
> "[PATCH v3 2/2] clk: renesas: cpg-mssr: add R8A7743 support" is not needed,

    How would "clocks" props _work_ without this patch?

> and introduces an additional dependency on "[PATCH 1/3] clk: renesas:
> cpg-mssr: add common R-Car Gen2 support".

    Yes, of course...

> Gr{oetje,eeting}s,
>
>                         Geert

MBR, Sergei
