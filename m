From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 29 Nov 2017 12:57:55 +0900
Subject: [PATCH] dt-bindings: uniphier: add bindings for UniPhier SoC
 family
In-Reply-To: <20171128152541.jdd2k5n5mjpppqxv@rob-hp-laptop>
References: <1511854150-26346-1-git-send-email-yamada.masahiro@socionext.com>
 <20171128152541.jdd2k5n5mjpppqxv@rob-hp-laptop>
Message-ID: <CAK7LNAQY5cq3K0No0O-qZnVnUvgFOyTARyiujy93EicX2-tG8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,


2017-11-29 0:25 GMT+09:00 Rob Herring <robh@kernel.org>:
> On Tue, Nov 28, 2017 at 04:29:10PM +0900, Masahiro Yamada wrote:
>
> Commit msg?

I will write something to fill the line.


>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  Documentation/devicetree/bindings/arm/uniphier.txt | 40 ++++++++++++++++++++++
>
> Perhaps arm/socionext/uniphier.txt instead.


I just recalled that I created the directory,
Documentation/devicetree/bindings/arm/uniphier/

So, perhaps, it should go to

Documentation/devicetree/bindings/arm/uniphier/uniphier.txt



>>  MAINTAINERS                                        |  1 +
>>  2 files changed, 41 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/uniphier.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/uniphier.txt b/Documentation/devicetree/bindings/arm/uniphier.txt
>> new file mode 100644
>> index 0000000..08d3cf3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/uniphier.txt
>> @@ -0,0 +1,40 @@
>> +Socionext UniPhier SoC family
>> +
>> +Required properties in the root node:
>> +  - compatible: should contain board and SoC compatible strings
>> +
>> +    SoC compatibles:
>> +      - "socionext,uniphier-ld4"   - LD4 SoC
>> +      - "socionext,uniphier-pro4"  - Pro4 SoC
>> +      - "socionext,uniphier-sld8"  - sLD8 SoC
>> +      - "socionext,uniphier-pro5"  - Pro5 SoC
>> +      - "socionext,uniphier-pxs2"  - PXs2 SoC
>> +      - "socionext,uniphier-ld6b"  - LD6b SoC
>> +      - "socionext,uniphier-ld11"  - LD11 SoC
>> +      - "socionext,uniphier-ld20"  - LD20 SoC
>> +      - "socionext,uniphier-pxs3"  - PXs3 SoC
>
> Sort this? Or are these in chronological order?

This is sorted in the chronological order.

I already put some bindings sorted chronologically
(for example, Documentation/devicetree/bindings/clock/uniphier-clock.txt)


(If the alphabetical sort is highly recommended,
I will do so, but I do not know what to do for the existing ones.)




>> +
>> +    Board compatibles:
>> +      - "socionext,uniphier-ld4-ref"      - LD4 Reference Board
>> +      - "socionext,uniphier-pro4-ref"     - Pro4 Reference Board
>> +      - "socionext,uniphier-pro4-ace"     - Pro4 Ace Board
>> +      - "socionext,uniphier-pro4-sanji"   - Pro4 Sanji Board
>> +      - "socionext,uniphier-sld8-ref"     - sLD8 Reference Board
>> +      - "socionext,uniphier-pxs2-gentil"  - PXs2 Gentil Board
>> +      - "socionext,uniphier-pxs2-vodka"   - PXs2 Vodka Board
>> +      - "socionext,uniphier-ld6b-ref"     - LD6b Reference Board
>> +      - "socionext,uniphier-ld11-ref"     - LD11 Reference Board
>> +      - "socionext,uniphier-ld11-global"  - LD11 Global Board
>> +      - "socionext,uniphier-ld20-ref"     - LD20 Reference Board
>> +      - "socionext,uniphier-ld20-global"  - LD20 Global Board
>> +      - "socionext,uniphier-pxs3-ref"     - PXs3 Reference Board
>
> I would group boards by each SoC. Then it clear which board compatibles
> go with each SoC compatible and you don't have to have the SoC name in
> the board compatible.
>

OK, will do.



-- 
Best Regards
Masahiro Yamada
