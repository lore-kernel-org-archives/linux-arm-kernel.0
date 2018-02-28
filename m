From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 28 Feb 2018 09:32:53 +0100
Subject: [PATCH 2/4] dt-bindings: arm: Document Renesas V3MSK and Wheat
 board part numbers
In-Reply-To: <4a2ae4c8-4a4b-1ea3-3416-2dfdffee6499@cogentembedded.com>
References: <20180228064911.vnax4vyqnq6lry52@verge.net.au>
 <4a2ae4c8-4a4b-1ea3-3416-2dfdffee6499@cogentembedded.com>
Message-ID: <CAMuHMdXisBvUDdsb=C7eoLQzpgC7cw5ncD4g2vJOjXM6YFecuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wed, Feb 28, 2018 at 8:38 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 2/28/2018 9:49 AM, Simon Horman wrote:
>> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
>> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
>> @@ -120,9 +120,9 @@ Boards:
>>       compatible = "renesas,sk-rzg1m", "renesas,r8a7743"
>>     - Stout (ADAS Starterkit, Y-R-CAR-ADAS-SKH2-BOARD)
>>       compatible = "renesas,stout", "renesas,r8a7790"
>> -  - V3MSK
>> +  - V3MSK (Y-ASK-RCAR-V3M-WS10)
>
>    https://elinux.org/R-Car/Boards/V3MSK (now that I'm reminded of this
> site) says the V3MSK's model # is RTP0RC77970SEB0010S.

Nope, that's Eagle :-(
Check the picture on https://elinux.org/R-Car/Boards/Eagle

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
