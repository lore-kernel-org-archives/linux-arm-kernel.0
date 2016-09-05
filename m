From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 5 Sep 2016 09:22:29 +0200
Subject: [PATCH] arm64: renesas: r8a7796/salvator-x: Add board part number
 to DT bindings
In-Reply-To: <20160902151955.GA27150@rob-hp-laptop>
References: <1472635054-24372-1-git-send-email-geert+renesas@glider.be>
 <20160902151955.GA27150@rob-hp-laptop>
Message-ID: <CAMuHMdU_TE0RxDqOvYsUtBOX5p8T7RCuZgXg_uP7Jgn-Bf3NSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Sep 2, 2016 at 5:19 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Aug 31, 2016 at 11:17:34AM +0200, Geert Uytterhoeven wrote:
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
>> index 90cf237ee5581978..42a046a97acba00f 100644
>> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
>> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
>> @@ -65,7 +65,7 @@ Boards:
>>      compatible = "renesas,porter", "renesas,r8a7791"
>>    - Salvator-X (RTP0RC7795SIPB0010S)
>>      compatible = "renesas,salvator-x", "renesas,r8a7795";
>> -  - Salvator-X
>> +  - Salvator-X (RTP0RC7796SIPB0011S)
>>      compatible = "renesas,salvator-x", "renesas,r8a7796";
>
> Seems like these should be different compatibles rather than the
> combination here defining exactly which board.

R-Car H3 (r8a7795) and R-Car M3-W (r8a7796) SiP are (sufficiently)
pin-compatible that they use the same board. So the only difference is really
the SoC.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
