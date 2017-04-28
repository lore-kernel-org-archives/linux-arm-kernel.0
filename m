From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 28 Apr 2017 16:23:38 +0200
Subject: [PATCH 1/8] [RFC] dt-bindings: renesas: Document R-Car H3 and
 M3-W SiP DT bindings
In-Reply-To: <20170428133923.ycbqixcxvcsonocn@rob-hp-laptop>
References: <1492593351-13835-1-git-send-email-geert+renesas@glider.be>
 <1492593351-13835-2-git-send-email-geert+renesas@glider.be>
 <20170428133923.ycbqixcxvcsonocn@rob-hp-laptop>
Message-ID: <CAMuHMdXv+Eb8RRCH3u18Lm=ZeBBxkErUxb4TN=Sf6RNFP0xO3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Apr 28, 2017 at 3:39 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Apr 19, 2017 at 11:15:44AM +0200, Geert Uytterhoeven wrote:
>> Document the SiP ("System-in-Package") versions of the R-Car H3 and M3-W
>> SoCs, which contain an R-Car H3 or M3-W SoC, RAM, and HyperFlash.
>>
>> Add their compatible values to all boards equipped with R-Car Gen3 SiPs.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Questions:
>>   - Do we need more compatible values, for different configurations?
>>     At least r8j7796 is available with either 2 GiB or 4 GiB of RAM,
>>     possibly using RAM parts from different vendors.
>
> Same die, just a different package? If so, I don't think you need a
> different compatible. It's going to be a different board from any
> non-SiP which should be enough to distinguish.

An SiP is more like a CPU daughterboard.

The different SiP-versions based on r8a7795 contain the same r8a7795 SoC die,
but different amounts of RAM, i.e. different RAM dies.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
