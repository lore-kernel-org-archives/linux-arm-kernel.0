From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 19 Jun 2018 00:09:25 +0800
Subject: [PATCH v4 01/19] dt-bindings: sram: sunxi: Add A13, A20 and A33
 SRAM controller bindings
In-Reply-To: <20180618160250.ik44c3gcbdxylmyd@flea>
References: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
 <20180618145843.14631-2-paul.kocialkowski@bootlin.com>
 <20180618160250.ik44c3gcbdxylmyd@flea>
Message-ID: <CAGb2v67bh4EJ3Xci3S01FhKztYc=h3bw=Ry5phhJrHdt4b=_4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 12:02 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Mon, Jun 18, 2018 at 04:58:25PM +0200, Paul Kocialkowski wrote:
>> This introduces dedicated bindings for the SRAM controllers found on the
>> A13, A20 and A33 sunxi platforms.
>>
>> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>
> Explaining why you need to add these new compatibles would be great.
>
>> diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
>> index d087f04a4d7f..19cc0b892672 100644
>> --- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
>> +++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
>> @@ -11,6 +11,9 @@ Controller Node
>>  Required properties:
>>  - compatible : should be:
>>      - "allwinner,sun4i-a10-sram-controller"
>> +    - "allwinner,sun5i-a13-sram-controller"
>> +    - "allwinner,sun7i-a20-sram-controller"
>> +    - "allwinner,sun8i-a33-sram-controller"
>
> And I think Chen-Yu asked you to rename this compatible to
> -system-controller for the previous iteration?

-system-control. It's not an actual controller, just a bunch of registers.

ChenYu
